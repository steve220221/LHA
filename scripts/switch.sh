#!/bin/bash
set -e

# Version Switching and Deployment Script for Hugo Site
# Usage: ./scripts/switch.sh <tag-name>
# Example: ./scripts/switch.sh v0.2.0-simple
# This will build and deploy the specified version, then return to main branch

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

echo -e "${BLUE}=== Hugo Site Version Deployment ===${NC}"
echo ""

# Remember the current branch
ORIGINAL_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}Warning: You have uncommitted changes${NC}"
    echo "These changes will be stashed before deploying."
    read -p "Continue? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    
    echo -e "${GREEN}Stashing changes...${NC}"
    git stash push -m "Auto-stash before deploying $TAG"
    STASHED=true
fi

echo -e "${GREEN}Deploying version: ${BLUE}$TAG${NC}"
echo ""

# Checkout the tag temporarily
git checkout "$TAG" 2>/dev/null

# Clean previous builds
echo -e "${GREEN}Cleaning previous builds...${NC}"
rm -rf public/ resources/

# Build the site
echo -e "${GREEN}Building site with version: $TAG${NC}"
hugo --minify

# Check if build was successful
if [ ! -d "public" ]; then
    echo -e "${RED}Error: Build failed - public directory not found${NC}"
    git checkout "$ORIGINAL_BRANCH"
    exit 1
fi

# Add CNAME file if needed (for custom domain)
if [ ! -f "public/CNAME" ]; then
    echo "lamonihistoricalassociation.org" > public/CNAME
    echo -e "${GREEN}Added CNAME file for custom domain${NC}"
fi

# Add .nojekyll to prevent GitHub from processing with Jekyll
touch public/.nojekyll

# Deploy to GitHub Pages
echo -e "${GREEN}Deploying to GitHub Pages...${NC}"

# Fetch the gh-pages branch
git fetch origin gh-pages:gh-pages 2>/dev/null || echo "Creating new gh-pages branch..."

# Use git worktree for cleaner deployment
if [ -d ".gh-pages-worktree" ]; then
    rm -rf .gh-pages-worktree
fi

git worktree add .gh-pages-worktree gh-pages 2>/dev/null || git worktree add -b gh-pages .gh-pages-worktree

# Copy built files to worktree
rsync -av --delete --exclude='.git' public/ .gh-pages-worktree/

# Commit and push from worktree
cd .gh-pages-worktree
git add -A
if git diff --staged --quiet; then
    echo -e "${YELLOW}No changes to deploy${NC}"
    cd ..
    git worktree remove .gh-pages-worktree
    git checkout "$ORIGINAL_BRANCH"
    exit 0
fi

git commit -m "Deploy $TAG - $(date '+%Y-%m-%d %H:%M:%S')"
git push origin gh-pages

cd ..
git worktree remove .gh-pages-worktree

# Return to original branch
echo ""
echo -e "${GREEN}Returning to ${BLUE}$ORIGINAL_BRANCH${GREEN} branch...${NC}"
git checkout "$ORIGINAL_BRANCH"

# Restore stashed changes if any
if [ "$STASHED" = true ]; then
    echo -e "${GREEN}Restoring stashed changes...${NC}"
    git stash pop
fi

echo ""
echo -e "${GREEN}✓ Successfully deployed version: ${BLUE}$TAG${NC}"
echo -e "${GREEN}✓ Returned to ${BLUE}$ORIGINAL_BRANCH${GREEN} branch${NC}"
echo ""
echo -e "Your site should be live at: ${BLUE}https://lamonihistoricalassociation.org${NC}"
echo ""
echo "Available versions:"
git tag -l | sed 's/^/  /'
