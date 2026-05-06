# Pi Compatibility Report

This fork adapts Matt Pocock's original skills repository for Pi agent.

## Attribution

Original repository: <https://github.com/mattpocock/skills>

Original author: Matt Pocock

This fork preserves the original MIT license and credits the original repository in `README.md`, `AGENTS.md`, and this report.

## What changed for Pi

- Added `package.json` with a Pi package manifest:

  ```json
  {
    "pi": {
      "skills": ["./skills"]
    }
  }
  ```

- Added `AGENTS.md` with Pi-specific maintenance notes.
- Added this compatibility report.
- Added `scripts/validate-pi-skills.mjs` to validate with Pi's own skill loader.
- Updated `scripts/link-skills.sh` to link skills into `~/.pi/agent/skills` instead of `~/.claude/skills`.
- Updated user-facing command examples from Claude-style `/<skill>` to Pi-style `/skill:<skill>`.
- Updated `setup-matt-pocock-skills` to prefer `AGENTS.md` for Pi context.
- Replaced Claude subagent/Task-tool language with Pi-friendly multi-pass or normal tool exploration workflows.
- Replaced the Claude-specific git guardrails skill with `git-guardrails-pi`, which uses `AGENTS.md` instructions plus an optional local git wrapper.

## Installation

Install directly from GitHub:

```bash
pi install https://github.com/lenkard/skills-pi
```

Try locally without installing:

```bash
git clone https://github.com/lenkard/skills-pi
cd skills-pi
pi --skill ./skills
```

Manual symlink install:

```bash
./scripts/link-skills.sh
```

## Invocation

Pi skill commands use `/skill:<name>`:

```text
/skill:tdd
/skill:diagnose
/skill:grill-me
/skill:setup-matt-pocock-skills
```

Skills with `disable-model-invocation: true` are intentionally hidden from automatic model selection and should be invoked manually with `/skill:<name>`.

## Validation result

Validated with:

```bash
node scripts/validate-pi-skills.mjs
```

Current result:

- 27 skills loaded from `./skills`
- 0 Pi skill diagnostics
- All skill names match their parent directories
- All skills have valid descriptions

## Skill inventory

### Engineering

- `diagnose`
- `grill-with-docs`
- `improve-codebase-architecture`
- `prototype`
- `setup-matt-pocock-skills` — manual invocation only
- `tdd`
- `to-issues`
- `to-prd`
- `triage`
- `zoom-out` — manual invocation only

### Productivity

- `caveman`
- `grill-me`
- `write-a-skill`

### Misc

- `git-guardrails-pi`
- `migrate-to-shoehorn`
- `scaffold-exercises`
- `setup-pre-commit`

### Personal / in-progress / deprecated

These remain loadable by Pi because they are valid Agent Skills, but they are not promoted as daily-use skills:

- `edit-article`
- `obsidian-vault`
- `handoff`
- `writing-beats`
- `writing-fragments`
- `writing-shape`
- `design-an-interface`
- `qa`
- `request-refactor-plan`
- `ubiquitous-language` — manual invocation only
