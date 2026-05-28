# Claude Code Skills

Shared custom skills for Claude Code.

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| syscheck | `/syscheck` | Diagnose CPU hogs, fan noise, crash-looping Docker containers, runaway processes |
| graphify | `/graphify` | Any input (code, docs, papers, images) → knowledge graph → clustered communities → HTML + JSON + audit report |
| ros2-robotics | auto | ROS2 patterns — nodes, topics, services, actions, launch files, lifecycle, real-time considerations |

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
