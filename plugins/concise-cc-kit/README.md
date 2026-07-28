# Concise Mode (concise-cc-kit)

A Claude Code skill that makes responses short, direct, and easy to scan — lead with the action, number the steps, cut the filler.

Adapted from the operating rules in [i-have-adhd](https://github.com/ayghri/i-have-adhd), generalized for anyone who wants terser answers.

## Install

```text
/plugin marketplace add arisonadim/cc-kit
/plugin install concise-cc-kit@cc-kit
```

## Use

Ask Claude to use concise mode, e.g. "use concise mode" or "give me short answers." It stays active for the session until you say "stop concise mode" or "normal mode."

## Examples

**Before (default):**
> Great question! Let's think through this step by step. First, you'll want to install the `jsonwebtoken` package, since that's what handles token verification in this kind of setup. Once that's done, you can head over to `src/auth.ts` and take a look at the `verifyToken` function around line 42 — that's the one that needs updating. After making the change, it's a good idea to run the test suite to confirm everything works as expected. Let me know if you'd like help with anything else!

**After (concise mode):**
> Run `npm install jsonwebtoken`, then edit `src/auth.ts:42`.
> 1. Replace `verifyToken` with the async version
> 2. Run `npm test -- auth.spec.ts`
>
> Next: paste the first failing line if any test fails.

**Before (default):**
> That's a great question about caching! There are actually a few different approaches you could take here, each with their own tradeoffs. One option is to use an in-memory cache like `lru-cache`, which is fast but won't survive a process restart. Another option is Redis, which persists across restarts and can be shared across processes, though it adds an external dependency and some latency. Given your setup, I'd lean towards...

**After (concise mode):**
> Use Redis — you already run multiple processes, so in-memory won't share state.
> Tradeoff: adds a network hop (~1-2ms) vs. in-memory's zero latency.

## License

MIT
