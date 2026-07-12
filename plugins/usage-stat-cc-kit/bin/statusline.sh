#!/bin/bash
input=$(cat)
five_hour=$(echo "$input" | grep -o '"five_hour":{[^}]*}')
used=$(echo "$five_hour" | grep -o '"used_percentage":[0-9.]*' | grep -o '[0-9.]*$' | head -1)
reset=$(echo "$five_hour" | grep -o '"resets_at":[0-9]*' | grep -o '[0-9]*$' | head -1)
used=${used:-0}
reset=${reset:-0}
now=$(date +%s)
left_sec=$(( reset - now ))
(( left_sec < 0 )) && left_sec=0
hours=$(( left_sec / 3600 ))
mins=$(( (left_sec % 3600) / 60 ))
remain=$(awk "BEGIN { printf \"%.1f\", 100 - $used }")
printf "5h left: %s%% | resets in %dh %02dm\n" "$remain" "$hours" "$mins"
