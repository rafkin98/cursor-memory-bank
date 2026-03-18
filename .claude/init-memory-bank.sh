#!/bin/sh
# Initialize Memory Bank orchestrator in a project directory
# Usage: sh /path/to/init-memory-bank.sh [--force] [target_dir]

set -e

FORCE=false
if [ "$1" = "--force" ]; then
    FORCE=true
    shift
fi

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/memory-bank-template"

echo "Initializing Memory Bank Orchestrator in: $(cd "$TARGET" && pwd)"
if [ "$FORCE" = true ]; then
    echo "  (--force: overwriting existing files)"
fi

# Create memory-bank directory structure
mkdir -p "$TARGET/memory-bank"/{creative,review,integration,validation,reflection,archive,security}

# Copy template files
for tmpl in "$TEMPLATE_DIR"/*.md; do
    basename=$(basename "$tmpl")
    dest="$TARGET/memory-bank/$basename"
    if [ "$FORCE" = true ] || [ ! -f "$dest" ]; then
        cp "$tmpl" "$dest"
        echo "  Created: memory-bank/$basename"
    else
        echo "  Skipped: memory-bank/$basename (already exists)"
    fi
done

# Create .claude directory
if [ ! -d "$TARGET/.claude" ]; then
    mkdir -p "$TARGET/.claude"
fi

# Copy CLAUDE.md (if source exists)
if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
    if [ "$FORCE" = true ] || [ ! -f "$TARGET/.claude/CLAUDE.md" ]; then
        cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET/.claude/CLAUDE.md"
        echo "  Created: .claude/CLAUDE.md"
    else
        echo "  Skipped: .claude/CLAUDE.md (already exists)"
    fi
else
    echo "  Skipped: .claude/CLAUDE.md (source not found)"
fi

# Copy skills
if [ "$FORCE" = true ] || [ ! -d "$TARGET/.claude/skills" ]; then
    rm -rf "$TARGET/.claude/skills"
    cp -r "$SCRIPT_DIR/skills" "$TARGET/.claude/skills"
    echo "  Created: .claude/skills/orchestrate/"
else
    echo "  Skipped: .claude/skills/ (already exists)"
fi

# Copy rules (if source exists)
if [ -d "$SCRIPT_DIR/rules" ]; then
    if [ "$FORCE" = true ] || [ ! -d "$TARGET/.claude/rules" ]; then
        rm -rf "$TARGET/.claude/rules"
        cp -r "$SCRIPT_DIR/rules" "$TARGET/.claude/rules"
        echo "  Created: .claude/rules/"
    else
        echo "  Skipped: .claude/rules/ (already exists)"
    fi
else
    echo "  Skipped: .claude/rules/ (source not found)"
fi

# Copy settings
if [ "$FORCE" = true ] || [ ! -f "$TARGET/.claude/settings.json" ]; then
    cp "$SCRIPT_DIR/settings.json" "$TARGET/.claude/settings.json"
    echo "  Created: .claude/settings.json (memory-bank write permissions)"
else
    echo "  Skipped: .claude/settings.json (already exists)"
fi

echo ""
echo "Memory Bank Orchestrator initialized."
echo ""
echo "Usage: Open your project with Claude Code and type:"
echo "  /orchestrate <describe your task>"
echo ""
echo "The orchestrator runs the full pipeline automatically:"
echo "  VAN -> PLAN -> CREATIVE -> BUILD -> SCAN -> JUDGE -> INTEGRATE -> VALIDATE -> PENTEST -> REFLECT -> ARCHIVE"
