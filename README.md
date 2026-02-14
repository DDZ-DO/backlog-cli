# backlog

Simple CLI for managing AI agent task backlogs.

Designed to help AI coding agents (Claude Code, Codex, etc.) maintain state across sessions and compactions.

## Problem

AI agents lose context on compaction/session restart. They forget what they were working on, what's done, what's pending. This leads to:
- Unfinished work
- Duplicate effort  
- No accountability

## Solution

A simple `BACKLOG.md` file in each repo, managed by this CLI:
- Structured format (parseable, validatable)
- Timestamps for tracking
- Git hooks for reminders
- `stale` detection for abandoned work

## Installation

```bash
# Clone
git clone https://github.com/DDZ-DO/backlog-cli
cd backlog-cli

# Install globally
sudo cp backlog /usr/local/bin/
# OR
cp backlog ~/.local/bin/

# Install hooks in a repo
cd /path/to/your/repo
cp /path/to/backlog-cli/hooks/* .git/hooks/
```

## Usage

```bash
# Initialize in a repo
cd /path/to/project
backlog init

# Add tasks
backlog add "Implement user authentication"
backlog add "Fix mobile layout"
backlog add "Write tests"

# Start working on a task
backlog start 1

# Complete a task
backlog done 1

# See status
backlog status

# Check for stale items (in-progress > 2 hours)
backlog stale
backlog stale 4  # custom threshold

# What should I work on next?
backlog next

# Remove a task
backlog drop 2
```

## BACKLOG.md Format

```markdown
# BACKLOG

## 🔄 In Progress
- [ ] #1 Implement user authentication (started: 2026-02-14T09:00:00Z)

## 📋 Todo
- [ ] #2 Fix mobile layout
- [ ] #3 Write tests

## ✅ Done
- [x] #4 Setup project (done: 2026-02-13T15:30:00Z)

---
*Letzte Aktualisierung: 2026-02-14T09:25:00Z*
```

## Git Hooks

### pre-commit
- Warns if no BACKLOG.md exists
- Warns about stale items (>2h in progress)

### post-commit  
- Reminds to update BACKLOG if it wasn't modified

## For AI Agents

Add this to your `CLAUDE.md` or agent instructions:

```markdown
## Task Management

1. At session start: Run `backlog status` to see current state
2. Before starting work: Run `backlog start <id>`
3. After completing work: Run `backlog done <id>`
4. Before session end: Run `backlog status` to verify state
5. If adding new tasks: Run `backlog add "description"`

NEVER leave a session with items in "In Progress" unless blocked.
```

## License

MIT
