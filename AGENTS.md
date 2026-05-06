# Pi Agent Notes

This repository is a Pi-adapted fork of Matt Pocock's original `mattpocock/skills` repository.

## Attribution

Original work: Matt Pocock — https://github.com/mattpocock/skills

This fork adapts the skills for Pi agent usage while preserving attribution and the original MIT license.

## Pi compatibility goals

- Skills are loaded through Pi's Agent Skills support (`SKILL.md` directories).
- Pi slash command examples use `/skill:<name>` instead of Claude-style `/<name>`.
- Repo-level instructions prefer `AGENTS.md`, which Pi reads as a context file.
- Claude-specific hook/subagent language should be replaced with Pi-compatible workflows.
- Package metadata is declared in `package.json` under the `pi.skills` manifest.

## Maintaining this fork

When editing skills:

- Keep every skill directory name identical to its `name` frontmatter.
- Keep each `description` present and under 1024 characters.
- Prefer relative references to bundled files.
- Avoid Claude-only features such as `.claude/settings.json`, `PreToolUse`, `Task tool`, and `subagent_type` unless explicitly documenting them as unsupported legacy behavior.
- For Pi, document commands as `/skill:<skill-name>`.

## Validation

After changes, validate with:

```bash
node scripts/validate-pi-skills.mjs
```

This uses Pi's own skill loader when available.
