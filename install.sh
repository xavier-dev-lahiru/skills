#!/usr/bin/env bash
set -e

SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_SKILLS="$HOME/.claude/skills"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"

mkdir -p "$CLAUDE_SKILLS"

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  [[ ! -f "$skill_dir/SKILL.md" ]] && continue

  target="$CLAUDE_SKILLS/$skill_name"
  mkdir -p "$target"
  cp "$skill_dir/SKILL.md" "$target/SKILL.md"
  echo "Installed: $skill_name"

  # Add CLAUDE.md entry if not already present
  if ! grep -q "skill: \"$skill_name\"" "$CLAUDE_MD" 2>/dev/null; then
    description=$(grep '^description:' "$skill_dir/SKILL.md" | sed 's/^description: //')
    trigger=$(grep '^trigger:' "$skill_dir/SKILL.md" | sed 's/^trigger: //')
    cat >> "$CLAUDE_MD" <<EOF

# $skill_name
- **$skill_name** (\`~/.claude/skills/$skill_name/SKILL.md\`) - $description. Trigger: \`$trigger\`
When the user types \`$trigger\`, invoke the Skill tool with \`skill: "$skill_name"\` before doing anything else.
EOF
    echo "  → Added CLAUDE.md entry"
  else
    echo "  → CLAUDE.md entry exists, skipped"
  fi
done

echo "Done. Restart Claude Code."
