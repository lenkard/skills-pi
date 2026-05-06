---
name: git-guardrails-pi
description: Set up Pi-friendly git safety guardrails to discourage or optionally block destructive git commands (push, reset --hard, clean, branch -D, checkout ., restore .). Use when user wants safer git behavior while working with Pi.
---

# Setup Pi Git Guardrails

Pi does not currently provide Claude-style `PreToolUse` hooks. This skill sets up **Pi-friendly guardrails** instead:

1. a durable instruction block in `AGENTS.md` that Pi reads as repo context, and
2. optionally, a local git wrapper script that can block dangerous commands when it is placed before the system `git` on `PATH`.

## What Gets Blocked or Flagged

- `git push` (all variants including `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

## Steps

### 1. Ask scope

Ask the user whether they want:

- **Instruction-only guardrails** — update `AGENTS.md`; works in Pi because Pi reads context files.
- **Instruction + wrapper guardrails** — also install a local `.pi/bin/git` wrapper and explain how to opt in by putting `.pi/bin` first on `PATH`.

Do not install the wrapper without explicit user approval.

### 2. Update AGENTS.md

Create or update an `AGENTS.md` section like this:

```markdown
## Git guardrails for Pi

Do not run destructive git commands unless the user explicitly asks for the exact command in the current conversation.

Blocked-by-default commands:

- `git push` and especially `git push --force`
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .`
- `git restore .`

If one of these appears necessary, stop and ask for confirmation first. Prefer non-destructive inspection commands (`git status`, `git diff`, `git log`, `git branch`) and explain the risk.
```

If `AGENTS.md` already exists, merge this section without overwriting unrelated content.

### 3. Optional: install wrapper script

The bundled script is at [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh).

If the user approved wrapper guardrails:

1. Create `.pi/bin/` if needed.
2. Copy the script to `.pi/bin/git`.
3. Make it executable with `chmod +x .pi/bin/git`.
4. Explain that it only takes effect when `.pi/bin` is before the real git in `PATH`.

For a one-off Pi session, the user can launch Pi from the repo with:

```bash
PATH="$PWD/.pi/bin:$PATH" pi
```

For persistent shell use, they can add this in their shell config when inside the project, but do not edit shell startup files unless the user asks.

### 4. Ask about customization

Ask if the user wants to add or remove blocked patterns. Edit the copied script accordingly.

### 5. Verify

Run a quick test from the repo if the wrapper was installed:

```bash
PATH="$PWD/.pi/bin:$PATH" git push origin main
```

It should exit non-zero and print a `BLOCKED` message. Do not run a real push without the wrapper active.
