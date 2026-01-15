#!/bin/bash
set -e

# Version Switching Script for Hugo Site
# Usage: ./scripts/switch.sh <tag-name>
# Example: ./scripts/switch.sh v0.2.0-simple

TAG=${1:-}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

# Show usage if no tag provided
if [ -z "$TAG" ]; then
    echo -e "${RED}Error: No tag specified${NC}"
    echo ""
    echo "Usage: ./scripts/switch.sh <tag-name>"
    echo ""
    echo "Available tags:"
    git tag -l | sed 's/^/  /'
    exit 1
fi

# Check if tag exists
if ! git rev-parse "$TAG" >/dev/null 2>&1; then
    echo -e "${RED}Error: Tag '$TAG' does not exist${NC}"
    echo ""
    echo "Available tags:"
    git tag -l | sed 's/^/  /'
    exit 1
fi

echo -e "${BLUE}=== Hugo Site Version Switcher ===${NC}"
echo ""

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}Warning: You have uncommitted changes${NC}"
    echo "These changes will be stashed before switching versions."
    read -p "Continue? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    
    echo -e "${GREEN}Stashing changes...${NC}"
    git stash push -m "Auto-stash before switching to $TAG"
fi

# Get current branch/tag
CURRENT_REF=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD)

echo -e "${GREEN}Current version: ${BLUE}$CURRENT_REF${NC}"
echo -e "${GREEN}Switching to: ${BLUE}$TAG${NC}"
echo ""

# Checkout the tag in detached HEAD state
git checkout "$TAG"

# Clean previous builds
echo -e "${GREEN}Cleaning previous builds...${NC}"
rm -rf public/ resources/

# Build the site
echo -e "${GREEN}Building site with version: $TAG${NC}"
hugo --minify

echo ""
echo -e "${GREEN}✓ Successfully switched to version: ${BLUE}$TAG${NC}"
echo ""
echo -e "${YELLOW}Note: You are now in 'detached HEAD' state${NC}"
echo "This is normal for viewing different versions."
echo ""
echo "What you can do:"
echo "  • ${GREEN}View locally:${NC} make dev (in another terminal)"
echo "  • ${GREEN}Deploy this version:${NC} make deploy-quick"
echo "  • ${GREEN}Switch to another version:${NC} ./scripts/switch.sh <other-tag>"
echo "  • ${GREEN}Return to main branch:${NC} git checkout main"
echo ""
echo "Available versions:"
git tag -l | sed 's/^/  /'
