# Hugo Development Makefile

# Default target - start development server
.DEFAULT_GOAL := dev

# Start Hugo development server
dev:
	hugo server --bind 0.0.0.0 --port 1313

# Start Hugo development server with drafts
dev-drafts:
	hugo server --bind 0.0.0.0 --port 1313 --buildDrafts

# Build the site for production
build:
	hugo --minify

# Clean build artifacts
clean:
	rm -rf public/ resources/

# Create a new post
new-post:
	@read -p "Enter post title: " title; \
	hugo new content "posts/$$(echo $$title | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g').md"

# Create a new page
new-page:
	@read -p "Enter page name: " page; \
	hugo new content "$$page.md"

# Install/update theme dependencies
theme-update:
	git submodule update --remote --merge

# Deploy to GitHub Pages (with optional version tag)
# Usage: make deploy VERSION=v0.1.2 MESSAGE="Release notes"
deploy:
	@if [ -z "$(VERSION)" ]; then \
		./scripts/deploy.sh "" "Update site"; \
	else \
		./scripts/deploy.sh "$(VERSION)" "$(MESSAGE)"; \
	fi

# Quick deploy without version tag
deploy-quick:
	./scripts/deploy.sh "" "Update site"

# Check git status before deploying
status:
	@echo "Git Status:"
	@git status --short
	@echo ""
	@echo "Current Branch:"
	@git branch --show-current
	@echo ""
	@echo "Recent Tags:"
	@git tag -l | tail -5
	@echo ""
	@echo "Last gh-pages commit:"
	@git log origin/gh-pages --oneline -1 2>/dev/null || echo "  (gh-pages branch not found locally)"

# Force GitHub Pages rebuild
rebuild-pages:
	@echo "Fetching gh-pages branch..."
	@git fetch origin gh-pages:gh-pages
	@git checkout gh-pages
	@git commit --allow-empty -m "Force rebuild - $$(date '+%Y-%m-%d %H:%M:%S')"
	@git push origin gh-pages
	@git checkout main
	@echo "GitHub Pages rebuild triggered!"

# Switch to a different version (tag)
switch:
	@if [ -z "$(VERSION)" ]; then \
		echo "Available versions:"; \
		git tag -l | sed 's/^/  /'; \
		echo ""; \
		echo "Usage: make switch VERSION=v0.2.0-simple"; \
		exit 1; \
	fi
	@./scripts/switch.sh "$(VERSION)"

# List all available versions
list-versions:
	@echo "Available site versions:"
	@git tag -l | sed 's/^/  /'
	@echo ""
	@echo "Current version:"
	@git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "  (detached HEAD)"

# Quick switches to common versions
switch-simple:
	@./scripts/switch.sh v0.2.0-simple

switch-full:
	@./scripts/switch.sh v0.2.0-full

# Return to main development branch
switch-main:
	@git checkout main
	@echo "Returned to main branch"

# Show help
help:
	@echo "Available commands:"
	@echo "  dev           - Start development server (default)"
	@echo "  dev-drafts    - Start development server including draft posts"
	@echo "  build         - Build site for production"
	@echo "  clean         - Clean build artifacts"
	@echo "  new-post      - Create a new blog post"
	@echo "  new-page      - Create a new page"
	@echo "  theme-update  - Update theme to latest version"
	@echo "  deploy        - Deploy to GitHub Pages with optional VERSION and MESSAGE"
	@echo "  deploy-quick  - Quick deploy without version tag"
	@echo "  status        - Check git status and recent tags"
	@echo "  rebuild-pages - Force GitHub Pages rebuild (if deploy isn't showing)"
	@echo ""
	@echo "Version Switching:"
	@echo "  list-versions - Show all available site versions"
	@echo "  switch        - Switch to a specific version (requires VERSION=tag)"
	@echo "  switch-simple - Switch to simplified event version"
	@echo "  make switch VERSION=v0.2.0-simple"
	@echo "  make switch-simple"

.PHONY: dev dev-drafts build clean new-post new-page theme-update deploy deploy-quick status rebuild-pages switch list-versions switch-simple switch-full switch-main
	@echo ""
	@echo "  help          - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make deploy VERSION=v0.1.2 MESSAGE='Add new feature'"
	@echo "  make deploy-quick"

.PHONY: dev dev-drafts build clean new-post new-page theme-update deploy deploy-quick status rebuild-pages help
