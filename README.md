# Lamoni - Hugo Website

A modern, fast static website built with [Hugo](https://gohugo.io/), the world's fastest framework for building websites.

## About Hugo

Hugo is a fast and modern static site generator written in Go. It's designed for speed and flexibility, making it perfect for:

- **Blazing Fast**: Hugo renders pages in milliseconds, not seconds
- **Content Management**: Write content in Markdown with front matter for metadata
- **Themes**: Extensive theme ecosystem for quick customization
- **Deployment**: Deploy anywhere - GitHub Pages, Netlify, Vercel, or any static host
- **Developer Friendly**: Live reload, syntax highlighting, and powerful templating

This project uses the [Ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke), a popular and well-maintained Hugo theme that provides a clean, responsive design out of the box.

## Quick Start

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) (v0.100.0 or later)
- [Git](https://git-scm.com/)

### Development

1. **Clone and setup** (if not already done):
   ```bash
   git clone <your-repo-url>
   cd lamoni
   git submodule update --init --recursive
   ```

2. **Start development server**:
   ```bash
   make
   # or
   make dev
   ```
   
   Your site will be available at `http://localhost:1313`

3. **View all available commands**:
   ```bash
   make help
   ```

## Getting Started for Developers

### Project Structure

```
lamoni/
├── archetypes/          # Content templates
├── assets/              # Assets to be processed (SCSS, JS, images)
├── content/             # Your content files (Markdown)
│   ├── posts/          # Blog posts
│   └── about.md        # Static pages
├── data/               # Data files (JSON, YAML, TOML)
├── layouts/            # Custom HTML templates
├── static/             # Static files (copied as-is)
├── themes/             # Hugo themes
│   └── ananke/         # Current theme (git submodule)
├── hugo.toml           # Site configuration
└── Makefile           # Development commands
```

### Adding Content

#### Create a New Blog Post

```bash
# Interactive way
make new-post

# Manual way
hugo new content posts/my-new-post.md
```

This creates a new Markdown file with front matter:

```markdown
+++
date = '2025-09-19T13:51:21-06:00'
draft = false
title = 'My New Post'
tags = ['tag1', 'tag2']
+++

Your content here in **Markdown**!
```

#### Create a New Page

```bash
# Interactive way
make new-page

# Manual way
hugo new content about.md
```

#### Front Matter Options

Common front matter variables:

```yaml
+++
title = "Page Title"
date = "2025-09-19T13:51:21-06:00"
draft = false                    # Set to true to hide from production
tags = ["hugo", "web"]          # Post tags
categories = ["Technology"]      # Post categories
description = "Page description" # Meta description
weight = 10                     # Order in menus (lower = higher priority)
+++
```

### Customizing Styles

#### Method 1: Override Theme Styles (Recommended)

Create custom CSS in `assets/css/`:

```bash
mkdir -p assets/css
echo "/* Custom styles */" > assets/css/custom.css
```

Then reference it in your layout or config.

#### Method 2: Modify Theme Directly

**Warning**: Changes will be lost when updating the theme.

```bash
# Edit theme styles
vim themes/ananke/assets/css/main.css
```

#### Method 3: Create Custom Layout

Override specific templates by copying from theme to your layouts directory:

```bash
# Copy theme template to customize
cp themes/ananke/layouts/_default/single.html layouts/_default/
# Now edit layouts/_default/single.html
```

### Building Sections and Layouts

#### Creating Custom Sections

1. **Create content directory**:
   ```bash
   mkdir content/portfolio
   ```

2. **Add section page**:
   ```bash
   hugo new content portfolio/_index.md
   ```

3. **Add content to section**:
   ```bash
   hugo new content portfolio/project-1.md
   ```

#### Custom Layouts

Create layouts for specific content types:

```bash
# Layout for all portfolio items
mkdir -p layouts/portfolio
touch layouts/portfolio/single.html    # Individual portfolio item
touch layouts/portfolio/list.html      # Portfolio listing page
```

Example `layouts/portfolio/single.html`:

```html
{{ define "main" }}
<article>
  <h1>{{ .Title }}</h1>
  <time>{{ .Date.Format "January 2, 2006" }}</time>
  <div class="content">
    {{ .Content }}
  </div>
</article>
{{ end }}
```

### Configuration

Edit `hugo.toml` to customize your site:

```toml
baseURL = 'https://yoursite.com'
languageCode = 'en-us'
title = 'Your Site Title'
theme = 'ananke'

[params]
  author = "Your Name"
  description = "Site description"
  
[menu]
  [[menu.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menu.main]]
    name = "About"
    url = "/about/"
    weight = 2
```

### Development Commands

| Command | Description |
|---------|-------------|
| `make` or `make dev` | Start development server |
| `make dev-drafts` | Include draft posts in development |
| `make build` | Build for production |
| `make clean` | Remove build artifacts |
| `make new-post` | Create new blog post |
| `make new-page` | Create new page |
| `make theme-update` | Update theme |

### Theme Customization

#### Updating the Theme

```bash
make theme-update
```

#### Using a Different Theme

1. Remove current theme:
   ```bash
   git submodule deinit themes/ananke
   git rm themes/ananke
   ```

2. Add new theme:
   ```bash
   git submodule add https://github.com/author/theme-name themes/theme-name
   ```

3. Update `hugo.toml`:
   ```toml
   theme = 'theme-name'
   ```

### Deployment

This site is deployed to **GitHub Pages** at [https://lamonihistoricalassociation.org](https://lamonihistoricalassociation.org)

**Repository**: `git@github.com:steve220221/LHA.git`  
**Deployment Branch**: `gh-pages`  
**Available Tags**: `v0.1.0`, `v0.1.1`

#### Quick Deploy

```bash
# Deploy without creating a version tag
make deploy-quick

# Deploy with a version tag
make deploy VERSION=v0.1.2 MESSAGE="Add new feature"
```

The deploy script will:
1. Check that your working directory is clean
2. Ensure you're on the `main` branch
3. Pull latest changes from origin
4. Build the site with `hugo --minify`
5. Deploy to the `gh-pages` branch
6. Create and push a version tag (if VERSION is provided)
7. Leave your working directory clean on `main`

#### Pre-Deployment Checklist

```bash
# Check current status
make status

# Test locally
make dev

# Ensure all changes are committed
git add .
git commit -m "Your changes"
git push origin main
```

#### Manual Deployment

If you need to deploy manually:

```bash
# Build the site
make build

# Run the deployment script
./scripts/deploy.sh v0.1.2 "Release notes"
```

#### Deployment Troubleshooting

- **Uncommitted changes**: Commit or stash changes before deploying
- **Wrong branch**: Ensure you're on `main` before deploying
- **Build fails**: Check Hugo errors with `make build`
- **Site not updating**: GitHub Pages may take a few minutes to update
- **Deploy succeeded but site not updating**: Force a rebuild with `make rebuild-pages`

#### Force GitHub Pages Rebuild

If you deployed successfully but the site isn't showing the latest changes:

```bash
make rebuild-pages
```

This will:
- Fetch the latest `gh-pages` branch
- Create an empty commit to trigger GitHub Pages rebuild
- Push to force a fresh deployment
- Return you to the `main` branch

**Note**: GitHub Pages can take 1-10 minutes to propagate changes. Also try a hard refresh (Cmd+Shift+R) or check in incognito mode to rule out browser caching.

### Tips and Best Practices

1. **Content Organization**: Use descriptive filenames and organize by date or category
2. **Images**: Place in `static/images/` or use page bundles in `content/posts/my-post/`
3. **SEO**: Always include `title` and `description` in front matter
4. **Performance**: Optimize images and use Hugo's built-in image processing
5. **Version Control**: Commit content changes regularly

### Troubleshooting

- **Site not loading**: Check that Hugo server is running on correct port
- **Theme not working**: Ensure theme is properly initialized as submodule
- **Content not showing**: Check that `draft = false` in front matter
- **Styles not updating**: Clear browser cache or use incognito mode

### Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Themes](https://themes.gohugo.io/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Ananke Theme Documentation](https://github.com/theNewDynamic/gohugo-theme-ananke)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `make dev`
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).
