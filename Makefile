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

# Show help
help:
	@echo "Available commands:"
	@echo "  dev         - Start development server (default)"
	@echo "  dev-drafts  - Start development server including draft posts"
	@echo "  build       - Build site for production"
	@echo "  clean       - Clean build artifacts"
	@echo "  new-post    - Create a new blog post"
	@echo "  new-page    - Create a new page"
	@echo "  theme-update- Update theme to latest version"
	@echo "  help        - Show this help message"

.PHONY: dev dev-drafts build clean new-post new-page theme-update help
