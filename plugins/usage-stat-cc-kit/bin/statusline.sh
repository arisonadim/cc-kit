#!/bin/bash
cache_file="${TMPDIR:-/tmp}/claude-usage-stat-cc-kit.cache"
cache_max_age=21600 # 6h: stale fallback data is worse than n/a

now=$(date +%s)
input=$(cat | tr -d '\n')
five_hour=$(echo "$input" | grep -o '"five_hour"[[:space:]]*:[[:space:]]*{[^}]*}')
used=$(echo "$five_hour" | grep -o '"used_percentage"[[:space:]]*:[[:space:]]*[0-9.]*' | grep -o '[0-9.]*$' | head -1)
reset=$(echo "$five_hour" | grep -o '"resets_at"[[:space:]]*:[[:space:]]*[0-9]*' | grep -o '[0-9]*$' | head -1)

if [[ -z "$used" || -z "$reset" ]]; then
  # Claude Code sometimes sends a payload without rate-limit data yet
  # (e.g. right after switching back to this session's window).
  # Fall back to the last known-good reading instead of showing n/a,
  # unless that reading is too old to be trustworthy.
  if [[ -f "$cache_file" ]]; then
    cache_mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null)
    if [[ -n "$cache_mtime" && $(( now - cache_mtime )) -le $cache_max_age ]]; then
      read -r used reset < "$cache_file"
    fi
  fi
  if [[ -z "$used" || -z "$reset" ]]; then
    printf "5h left: n/a\n"
    exit 0
  fi
else
  printf "%s %s\n" "$used" "$reset" > "$cache_file"
fi
left_sec=$(( reset - now ))
(( left_sec < 0 )) && left_sec=0
hours=$(( left_sec / 3600 ))
mins=$(( (left_sec % 3600) / 60 ))
remain=$(awk "BEGIN { printf \"%.1f\", 100 - $used }")
printf "5h left: %s%% | resets in %dh %02dm\n" "$remain" "$hours" "$mins"
