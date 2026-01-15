# Version Switching Quick Reference

## Available Versions

- **v0.2.0-full** - Full site with all navigation (main branch)
- **v0.2.0-simple** - Simplified event view (no nav, just register + donate)

## Quick Commands

```bash
# List all versions
make list-versions

# Switch to simplified version
make switch-simple

# Switch to full version  
make switch-full

# Switch to any version
make switch VERSION=v0.2.0-simple

# Return to main branch for development
make switch-main
```

## Event Day Workflow

### Before the Event
1. Test both versions locally:
   ```bash
   make switch-simple
   make dev  # View at localhost:1313
   
   make switch-full
   make dev  # View at localhost:1313
   ```

2. Both versions are already deployed if needed

### During the Event - Switch to Simple View
```bash
make switch-simple
make deploy-quick
```
*Site updates in 1-10 minutes*

### After the Event - Return to Full View
```bash
make switch-full
make deploy-quick
```

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
- The script will automatically stash them
- Retrieve later with `git stash pop`

**"Detached HEAD state"**
- This is normal when viewing tagged versions
- Use `make switch-main` to return to normal development

**Changes not showing**
- Wait 1-10 minutes for GitHub Pages to update
- Try `make rebuild-pages` to force update
- Hard refresh browser (Cmd+Shift+R)

## Technical Details

- Versions are stored as git tags
- Each tag points to a specific commit
- Switching checks out that commit (detached HEAD)
- The script rebuilds the site automatically
- Deploy deploys whatever version is currently checked out
