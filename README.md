# Claude Code Skills

Shared custom skills for Claude Code.

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| syscheck | `/syscheck` | Diagnose CPU hogs, fan noise, crash-looping Docker containers, runaway processes |

## Install

```bash
git clone <this-repo> ~/claude-skills
cd ~/claude-skills
bash install.sh
```

Then restart Claude Code.

## Add new skill

1. Create `<skill-name>/SKILL.md`
2. Update `README.md` table
3. `install.sh` picks it up automatically — no edit needed
