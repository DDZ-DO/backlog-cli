#!/bin/bash
#
# Setup backlog in a repository
# Usage: curl -sL https://raw.githubusercontent.com/DDZ-DO/backlog-cli/main/setup-repo.sh | bash
#

set -e

REPO_URL="https://raw.githubusercontent.com/DDZ-DO/backlog-cli/main"

echo "🔧 Setting up backlog in $(pwd)..."

# Check if we're in a git repo
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository. Run this from your repo root."
    exit 1
fi

# Install CLI if not present
if ! command -v backlog &> /dev/null; then
    echo "📦 Installing backlog CLI..."
    mkdir -p ~/.local/bin
    curl -sL "$REPO_URL/backlog" -o ~/.local/bin/backlog
    chmod +x ~/.local/bin/backlog
    echo "   Installed to ~/.local/bin/backlog"
    echo "   Make sure ~/.local/bin is in your PATH"
fi

# Install hooks
echo "🪝 Installing git hooks..."
curl -sL "$REPO_URL/hooks/pre-commit" -o .git/hooks/pre-commit
curl -sL "$REPO_URL/hooks/post-commit" -o .git/hooks/post-commit
chmod +x .git/hooks/pre-commit .git/hooks/post-commit

# Init BACKLOG.md if not exists
if [ ! -f "BACKLOG.md" ]; then
    echo "📋 Creating BACKLOG.md..."
    backlog init
else
    echo "📋 BACKLOG.md already exists"
fi

echo ""
echo "✅ Done! Next steps:"
echo "   1. Add tasks:        backlog add \"Your task\""
echo "   2. Start working:    backlog start 1"
echo "   3. Complete task:    backlog done 1"
echo "   4. Update CLAUDE.md with task management rules"
echo ""
