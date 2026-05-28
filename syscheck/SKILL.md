---
name: syscheck
description: Diagnose system health issues — CPU hogs, fan activity, crash-looping Docker containers, runaway processes. Run diagnostic commands and summarize root causes with actionable options.
trigger: /syscheck
---

# /syscheck

Diagnose why system is hot/slow/loud. Check CPU, memory, Docker containers, and crash loops. Report root causes and offer fixes.

## Usage

```
/syscheck            # full system health check
/syscheck cpu        # CPU + process focus only
/syscheck docker     # Docker containers only
/syscheck fan        # thermal + fan focus
```

## Behavior

### Always run (in parallel):
1. `ps aux --sort=-%cpu | head -20` — top CPU consumers
2. `docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}"` — container state
3. `free -h` — memory pressure
4. `uptime` — load average

### Triage logic:

**CPU hogs:**
- Any process >5% sustained = flag it
- Identify owner: user vs UID number (UID not in /etc/passwd = container process leaking to host)
- Dev servers (webpack, react-scripts, vite, nodemon) running overnight = always flag

**Docker:**
- `Restarting` status = crash loop = repeated CPU spikes = flag + show logs
- Dev containers (react-scripts, nodemon, ts-node-dev) = flag as non-prod waste
- Containers up >12hrs with dev servers = flag

**Thermal:**
- Sustained multi-process CPU load + container churn = root cause of fan noise
- Report: which processes, how long running, estimated impact

### Output format:
1. **Root causes** — ranked by impact
2. **Crash loops** — container names + last error line
3. **Actions** — specific commands, ask before running destructive ones (docker stop)

### Safety:
- Never auto-run `docker stop` or `kill` — always show command and ask
- Exception: user already confirmed in same session → proceed
