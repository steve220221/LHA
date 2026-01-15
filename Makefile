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
	@echo "  help          - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make deploy VERSION=v0.1.2 MESSAGE='Add new feature'"
	@echo "  make deploy-quick"

.PHONY: dev dev-drafts build clean new-post new-page theme-update deploy deploy-quick status help
