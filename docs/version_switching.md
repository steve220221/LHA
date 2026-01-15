# Version Switching Quick Reference

## Available Versions

- **v0.2.0-full** - Full site with all navigation (main branch)
- **v0.2.0-simple** - Simplified event view (no nav, just register + donate)

## Quick Commands

```bash
# List all versions
make list-versions

# Deploy simplified version (builds and deploys it)
./scripts/switch.sh v0.2.0-simple
# OR
make switch-simple

# Deploy full version
./scripts/switch.sh v0.2.0-full
# OR
make switch-full

# Deploy any version
make switch VERSION=v0.2.0-simple
```

## Event Day Workflow

### Before the Event
Test versions locally using the regular dev workflow on different branches.

### During the Event - Deploy Simple View
```bash
./scripts/switch.sh v0.2.0-simple
```
*Deploys immediately. Site updates in 1-10 minutes. You stay on main branch.*

### After the Event - Deploy Full View
```bash
./scripts/switch.sh v0.2.0-full
```

## How It Works

The script:
1. Stashes any uncommitted changes (if needed)
2. Temporarily checks out the specified tag
3. Builds the site from that tag
4. Deploys to GitHub Pages (gh-pages branch)
5. Returns you to main branch
6. Restores any stashed changes

**You end up back on main branch** - no detached HEAD state!

## Creating New Versions

```bash
# 1. Create topic branch
git checkout -b features/holiday-theme

# 2. Make your changes
# Edit layouts, content, styling, etc.

# 3. Commit and tag
git add -A
git commit -m "Create holiday theme"
git tag -a v0.2.2-holiday -m "Holiday themed version"

# 4. Return to main
git checkout main

# 5. Push everything
git push origin features/holiday-theme
git push origin --tags
```

## Troubleshooting

**"You have uncommitted changes"**
- The script will automatically stash them and restore after deployment

**Changes not showing**
- Wait 1-10 minutes for GitHub Pages to update
- Try `make rebuild-pages` to force update
- Hard refresh browser (Cmd+Shift+R)

**Need to test a version locally before deploying**
- Checkout the tag: `git checkout v0.2.0-simple`
- Run dev server: `make dev`
- Return to main: `git checkout main`

## Technical Details

- Versions are stored as git tags
- Each tag points to a specific commit
- The script temporarily checks out the tag, builds, deploys, then returns to main
- Deploy uses git worktree for clean gh-pages management
- You always end up back on main branch after deployment
