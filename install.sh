#!/usr/bin/env sh
# Install the onverwachts-so skill into every agent tool on this machine.
# Zero dependencies — pure POSIX sh. (For a richer installer that auto-detects
# 70+ agents, use the vercel-labs/skills CLI: `npx skills add <user>/onverwachts-so`.)
#
# Usage:
#   ./install.sh             symlink the skill into all known agent dirs (default)
#   ./install.sh --copy      copy instead of symlink (Windows / no-symlink envs)
#   ./install.sh --uninstall remove the skill from all known agent dirs
#
# Targets cover every supported tool:
#   ~/.agents/skills  -> Cursor, opencode, Codex, Gemini CLI, Copilot CLI
#   ~/.claude/skills  -> Claude Code (does not read ~/.agents)

set -eu

SKILL="onverwachts-so"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$SCRIPT_DIR/skills/$SKILL"
TARGETS="$HOME/.agents/skills $HOME/.claude/skills"

MODE="symlink"
for arg in "$@"; do
  case "$arg" in
    --copy)      MODE="copy" ;;
    --uninstall) MODE="uninstall" ;;
    -h|--help)   sed -n '2,17p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg (try --help)" >&2; exit 1 ;;
  esac
done

[ -f "$SRC/SKILL.md" ] || { echo "error: $SRC/SKILL.md not found" >&2; exit 1; }

for base in $TARGETS; do
  dest="$base/$SKILL"
  rm -rf "$dest"
  [ "$MODE" = "uninstall" ] && { echo "removed  $dest"; continue; }
  mkdir -p "$base"
  if [ "$MODE" = "copy" ]; then
    cp -R "$SRC" "$dest"; echo "copied   -> $dest"
  else
    ln -s "$SRC" "$dest"; echo "linked   $dest -> $SRC"
  fi
done

[ "$MODE" = "uninstall" ] || printf '\nDone. Restart your agent tool to pick up the skill.\n'
