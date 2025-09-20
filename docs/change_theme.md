# Changing Hugo Themes

This comprehensive guide explains how to pick, install, and customize Hugo themes for your site. We'll cover theme selection criteria, where files go in a Hugo site structure, and step-by-step instructions for switching themes safely.

## Understanding Hugo Themes

### What Are Hugo Themes?

Hugo themes are pre-built templates that define:

- **Visual appearance** - Colors, fonts, layouts
- **Site structure** - How content is organized and displayed
- **Functionality** - Features like comments, search, galleries
- **Responsive design** - Mobile and desktop optimization
- **Content types** - Support for blogs, portfolios, documentation

### Theme Architecture

Hugo themes consist of:

- **Layouts** - HTML templates that define page structure
- **Assets** - CSS, JavaScript, images, and fonts
- **Static files** - Favicon, robots.txt, etc.
- **Archetypes** - Content templates for new pages
- **Configuration** - Theme-specific settings

## Step 1: Choosing the Right Theme

### Consider Your Needs

1. **Purpose of your site**:
   - Blog/News site
   - Portfolio
   - Documentation
   - Business/Corporate
   - Event/Conference site
   - E-commerce

2. **Required features**:
   - Contact forms
   - Gallery/Portfolio display
   - Multi-language support
   - SEO optimization
   - Social media integration
   - Comments system

3. **Technical requirements**:
   - Mobile responsiveness
   - Loading speed
   - Accessibility compliance
   - Browser compatibility
   - Search functionality

### Where to Find Themes

1. **Official Hugo Themes**:
   - Visit [https://themes.gohugo.io](https://themes.gohugo.io)
   - Filter by tags: `blog`, `portfolio`, `business`, etc.
   - Check star ratings and recent updates
   - Review demo sites

2. **GitHub repositories**:
   - Search for "hugo theme" on GitHub
   - Check stars, forks, and last update date
   - Read documentation and issues

3. **Premium theme marketplaces**:
   - ThemeForest
   - Creative Market
   - Gumroad
   - Independent developers

### Evaluating Themes

#### Essential Criteria

1. **Active maintenance**:
   - Recent commits (within 6 months)
   - Responsive maintainer
   - Regular bug fixes and updates

2. **Documentation quality**:
   - Clear installation instructions
   - Configuration examples
   - Customization guides
   - Troubleshooting section

3. **Community support**:
   - GitHub stars and forks
   - Active issues and discussions
   - User testimonials

4. **Hugo compatibility**:
   - Minimum Hugo version required
   - Works with latest Hugo release
   - Uses modern Hugo features

#### Technical Evaluation

1. **Performance**:
   - Lighthouse scores
   - Page load times
   - Image optimization
   - Minimal dependencies

2. **Code quality**:
   - Clean, semantic HTML
   - Modern CSS practices
   - Accessible markup
   - Valid HTML/CSS

3. **SEO features**:
   - Structured data support
   - Meta tag management
   - Sitemap generation
   - Social media optimization

## Step 2: Popular Theme Recommendations

### For Blogs and Personal Sites

1. **Ananke** (currently installed):
   - Clean, modern design
   - Excellent mobile support
   - Good SEO features
   - Well-maintained

2. **PaperMod**:
   - Minimalist design
   - Fast loading
   - Dark/light mode toggle
   - Great for tech blogs

3. **Terminal**:
   - Developer-focused
   - Terminal-inspired design
   - Syntax highlighting
   - Dark theme

### For Business/Corporate

1. **Docsy**:
   - Documentation-focused
   - Corporate appearance
   - Multi-language support
   - Search functionality

2. **Universal**:
   - Business template
   - Portfolio sections
   - Contact forms
   - E-commerce ready

3. **Forty**:
   - Modern business design
   - Landing page focus
   - Portfolio showcase
   - Clean typography

### For Events/Conferences

1. **Conference**:
   - Event-specific layouts
   - Speaker profiles
   - Schedule displays
   - Registration integration

2. **Eventify**:
   - Modern event design
   - Countdown timers
   - Sponsor showcases
   - Ticket integration

## Step 3: Backing Up Current Setup

### Before Changing Themes

1. **Commit current state**:
   ```bash
   # Navigate to your Hugo site
   cd /Users/davidrichards/codes/lamoni
   
   # Commit all current changes
   git add .
   git commit -m "Backup before theme change"
   
   # Create a backup branch
   git branch backup-ananke
   ```

2. **Document current configuration**:
   ```bash
   # Copy current config for reference
   cp hugo.toml hugo.toml.backup
   
   # Note current theme name
   echo "Current theme: ananke" > theme-backup-notes.txt
   ```

3. **Export content structure**:
   ```bash
   # List current content for reference
   find content -name "*.md" > content-structure.txt
   ```

## Step 4: Installing a New Theme

### Method 1: Git Submodule (Recommended)

1. **Remove current theme** (if changing):
   ```bash
   # Remove current theme submodule
   git submodule deinit themes/ananke
   git rm themes/ananke
   rm -rf .git/modules/themes/ananke
   ```

2. **Add new theme**:
   ```bash
   # Example: Installing PaperMod theme
   git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
   
   # Update submodules
   git submodule update --init --recursive
   ```

3. **Update configuration**:
   ```toml
   # In hugo.toml
   baseURL = 'https://lamonihistoricalassociation.org/'
   languageCode = 'en-us'
   title = 'Lamoni Historical Association'
   theme = 'PaperMod'  # Changed from 'ananke'
   ```

### Method 2: Direct Download

1. **Download theme**:
   ```bash
   # Download and extract theme
   cd themes
   wget https://github.com/adityatelange/hugo-PaperMod/archive/master.zip
   unzip master.zip
   mv hugo-PaperMod-master PaperMod
   rm master.zip
   ```

2. **Not recommended for production** (harder to update).

### Method 3: Hugo Modules (Advanced)

1. **Initialize Hugo modules**:
   ```bash
   hugo mod init github.com/yourusername/yoursite
   ```

2. **Add theme as module**:
   ```toml
   # In hugo.toml
   [module]
     [[module.imports]]
       path = "github.com/adityatelange/hugo-PaperMod"
   ```

## Step 5: Theme Configuration

### Understanding Configuration Files

1. **hugo.toml** - Main site configuration
2. **config/_default/** - Split configuration files
3. **themes/THEME_NAME/exampleSite/** - Theme examples

### Basic Configuration

1. **Update hugo.toml**:
   ```toml
   baseURL = 'https://lamonihistoricalassociation.org/'
   languageCode = 'en-us'
   title = 'Lamoni Historical Association'
   theme = 'PaperMod'

   # Theme-specific parameters
   [params]
     # Theme customization options
     author = "Lamoni Historical Association"
     description = "Preserving and sharing Lamoni's rich history"
     
     # Enable features
     showToc = true
     TocOpen = false
     hidemeta = false
   ```

2. **Copy example configuration**:
   ```bash
   # Check if theme has example configuration
   ls themes/PaperMod/exampleSite/
   
   # Copy example config if available
   cp themes/PaperMod/exampleSite/hugo.toml hugo-example.toml
   ```

### Menu Configuration

```toml
# In hugo.toml
[menu]
  [[menu.main]]
    name = "Home"
    url = "/"
    weight = 10
    
  [[menu.main]]
    name = "About"
    url = "/about/"
    weight = 20
    
  [[menu.main]]
    name = "Symposium"
    url = "/symposium/"
    weight = 30
    
  [[menu.main]]
    name = "Contact"
    url = "/contact/"
    weight = 40
```

## Step 6: Content Migration

### Understanding Content Types

Different themes support different content types:

- **Posts** - Blog entries
- **Pages** - Static content
- **Sections** - Content groupings
- **Taxonomies** - Tags and categories

### Adapting Content

1. **Check content compatibility**:
   ```bash
   # Test build with new theme
   hugo server --buildDrafts
   ```

2. **Update front matter** if needed:
   ```yaml
   # Old Ananke format
   +++
   title = "My Post"
   date = "2025-09-19"
   draft = false
   +++

   # New theme might prefer YAML
   ---
   title: "My Post"
   date: 2025-09-19
   draft: false
   featured_image: "/images/hero.jpg"  # Theme-specific
   ---
   ```

3. **Adjust content structure**:
   ```bash
   # Some themes expect different folder structures
   # Move content if necessary
   mv content/posts/my-post.md content/blog/my-post.md
   ```

## Step 7: Customization

### Override Theme Files

Hugo uses a specific order to find files:

1. **Your site files** (highest priority)
2. **Theme files** (fallback)

### Customizing Layouts

1. **Copy theme layout to override**:
   ```bash
   # Copy theme layout to your site
   cp themes/PaperMod/layouts/_default/single.html layouts/_default/
   
   # Now edit layouts/_default/single.html
   ```

2. **Create custom partial**:
   ```bash
   # Create custom header
   mkdir -p layouts/partials
   cp themes/PaperMod/layouts/partials/head.html layouts/partials/
   ```

### Customizing Styles

1. **Override CSS**:
   ```bash
   # Create custom CSS
   mkdir -p assets/css
   echo "/* Custom styles */" > assets/css/custom.css
   ```

2. **Include in theme**:
   ```html
   <!-- In layouts/partials/head.html -->
   {{ $custom := resources.Get "css/custom.css" | resources.Minify }}
   <link rel="stylesheet" href="{{ $custom.RelPermalink }}">
   ```

### Theme-Specific Customizations

Each theme has unique customization options:

1. **Check theme documentation**:
   ```bash
   # Read theme README
   cat themes/PaperMod/README.md
   
   # Check example site
   ls themes/PaperMod/exampleSite/
   ```

2. **Common customizations**:
   - Color schemes
   - Font choices
   - Logo placement
   - Footer content
   - Social media links

## Step 8: Testing and Deployment

### Local Testing

1. **Test thoroughly**:
   ```bash
   # Start development server
   hugo server --buildDrafts
   
   # Test on different devices/browsers
   # Check all pages load correctly
   # Verify forms still work
   ```

2. **Performance testing**:
   ```bash
   # Build for production
   hugo --gc --minify
   
   # Check build output
   ls -la public/
   ```

### Pre-deployment Checklist

- [ ] All pages render correctly
- [ ] Navigation works properly
- [ ] Images display correctly
- [ ] Forms function as expected
- [ ] Mobile responsiveness verified
- [ ] Loading speed acceptable
- [ ] SEO meta tags present

### Deploy

1. **Commit changes**:
   ```bash
   git add .
   git commit -m "Switch to PaperMod theme"
   git push
   ```

2. **Monitor deployment**:
   - Check GitHub Actions status
   - Verify live site functionality
   - Test critical user flows

## Step 9: Troubleshooting

### Common Issues

1. **Theme not loading**:
   ```bash
   # Check theme name in config
   grep "theme =" hugo.toml
   
   # Verify theme directory exists
   ls themes/
   
   # Update submodules
   git submodule update --init --recursive
   ```

2. **Content not displaying**:
   - Check content front matter format
   - Verify content type compatibility
   - Review theme documentation

3. **Styling issues**:
   - Clear browser cache
   - Check CSS file loading
   - Verify asset pipeline configuration

4. **Build failures**:
   ```bash
   # Check Hugo version compatibility
   hugo version
   
   # Test build locally
   hugo --gc --minify --verbose
   ```

### Getting Help

1. **Theme documentation**:
   - README files
   - Wiki pages
   - Example sites

2. **Community support**:
   - GitHub issues
   - Hugo forum
   - Discord/Slack channels

3. **Professional help**:
   - Freelance developers
   - Hugo consultants
   - Web design agencies

## Step 10: Maintenance

### Keeping Themes Updated

1. **Regular updates**:
   ```bash
   # Update theme submodule
   git submodule update --remote --merge
   
   # Test after updates
   hugo server
   
   # Commit if working
   git commit -am "Update theme"
   ```

2. **Monitor for issues**:
   - Watch theme repository for updates
   - Test updates in development first
   - Keep backup branches

### Best Practices

1. **Documentation**:
   - Document your customizations
   - Keep notes on configuration changes
   - Maintain backup configurations

2. **Version control**:
   - Use branches for theme experiments
   - Tag stable releases
   - Keep detailed commit messages

3. **Performance monitoring**:
   - Regular speed tests
   - Monitor Core Web Vitals
   - Check mobile performance

## Theme-Specific Guides

### Switching from Ananke to PaperMod

1. **Key differences**:
   - PaperMod uses YAML front matter
   - Different parameter names
   - Enhanced performance focus

2. **Migration steps**:
   ```bash
   # Install PaperMod
   git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
   ```

3. **Configuration updates**:
   ```toml
   [params]
     env = "production"
     title = "Lamoni Historical Association"
     description = "Preserving Lamoni's history"
     author = "Lamoni Historical Association"
     
     defaultTheme = "auto"
     ShowReadingTime = true
     ShowShareButtons = true
     ShowPostNavLinks = true
   ```

### Switching to Docsy (for documentation)

1. **Install Docsy**:
   ```bash
   git submodule add https://github.com/google/docsy.git themes/docsy
   cd themes/docsy
   npm install
   ```

2. **Configure for documentation**:
   ```toml
   [params]
     github_repo = "https://github.com/yourusername/lamoni"
     github_branch = "main"
     edit_page = true
   ```

This comprehensive guide should help you successfully change and customize Hugo themes while maintaining your site's functionality and content.
