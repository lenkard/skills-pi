Skills are organized into bucket folders under `skills/`:

- `engineering/` — daily code work
- `productivity/` — daily non-code workflow tools
- `misc/` — kept around but rarely used
- `personal/` — tied to my own setup, not promoted
- `in-progress/` — drafts not yet ready to ship
- `deprecated/` — no longer used

Every promoted skill in `engineering/`, `productivity/`, or `misc/` must have a reference in the top-level `README.md`. For Pi compatibility, package loading is declared in `package.json` under `pi.skills`. The legacy `.claude-plugin/plugin.json` may remain for Claude users, but Pi does not rely on it. Skills in `personal/`, `in-progress`, and `deprecated/` should not appear in the promoted README sections.

Each skill entry in the top-level `README.md` must link the skill name to its `SKILL.md`.

Each bucket folder has a `README.md` that lists every skill in the bucket with a one-line description, with the skill name linked to its `SKILL.md`.
