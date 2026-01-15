#!/bin/bash
set -e

# GitHub Pages Deployment Script for Hugo Site
# Usage: ./scripts/deploy.sh [version] [message]
# Example: ./scripts/deploy.sh v0.1.2 "Add new feature"

VERSION=${1:-}
MESSAGE=${2:-"Update site"}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment process...${NC}"

# Check if working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}Warning: You have uncommitted changes${NC}"
    echo "Please commit or stash your changes before deploying"
    git status --short
    exit 1
fi

# Ensure we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${RED}Error: You must be on the main branch to deploy${NC}"
    echo "Current branch: $CURRENT_BRANCH"
    exit 1
fi

# Pull latest changes
echo -e "${GREEN}Pulling latest changes from origin...${NC}"
git pull origin main

# Clean previous builds
echo -e "${GREEN}Cleaning previous builds...${NC}"
rm -rf public/ resources/

# Build the site
echo -e "${GREEN}Building site for production...${NC}"
hugo --minify

# Check if build was successful
if [ ! -d "public" ]; then
    echo -e "${RED}Error: Build failed - public directory not found${NC}"
    exit 1
fi

# Add CNAME file if needed (for custom domain)
if [ ! -f "public/CNAME" ]; then
    echo "lamonihistoricalassociation.org" > public/CNAME
    echo -e "${GREEN}Added CNAME file for custom domain${NC}"
fi

# Add .nojekyll to prevent GitHub from processing with Jekyll
touch public/.nojekyll

# Deploy to GitHub Pages (assuming gh-pages branch)
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
    exit 0
fi

git commit -m "$MESSAGE - $(date '+%Y-%m-%d %H:%M:%S')"
git push origin gh-pages

cd ..
git worktree remove .gh-pages-worktree

# Tag the release if version is provided
if [ -n "$VERSION" ]; then
    echo -e "${GREEN}Creating version tag: $VERSION${NC}"
    git tag -a "$VERSION" -m "$MESSAGE"
    git push origin "$VERSION"
    echo -e "${GREEN}Tag $VERSION created and pushed${NC}"
fi

echo -e "${GREEN}Deployment complete!${NC}"
echo -e "${GREEN}Your site should be live at: https://lamonihistoricalassociation.org${NC}"
echo ""
echo "Summary:"
echo "  - Built site with hugo --minify"
echo "  - Deployed to gh-pages branch"
if [ -n "$VERSION" ]; then
    echo "  - Tagged as $VERSION"
fi
echo "  - Working directory is clean"
