# Hosting Your Hugo Site on GitHub Pages

This guide explains how to host your Hugo site on GitHub Pages, including setting up DNS, configuring GitHub Actions for automatic deployment, and managing your repository. We'll cover both scenarios: creating a fresh GitHub account or using an existing one.

## Overview

GitHub Pages is a free static site hosting service that works perfectly with Hugo. Benefits include:

- **Free hosting** for public repositories
- **Custom domain support** with SSL certificates
- **Automatic deployment** via GitHub Actions
- **Version control** built-in with Git
- **Collaboration features** for team management
- **Global CDN** for fast loading worldwide

## Prerequisites

- Hugo site ready for deployment
- Domain name (optional, can use github.io subdomain)
- Basic understanding of Git and command line

## Option A: Creating a Fresh GitHub Account

### Step 1: Create New GitHub Account

1. **Sign up for GitHub**:
   - Go to [https://github.com](https://github.com)
   - Click "Sign up"
   - Choose a username (this will be part of your URL: `username.github.io`)
   - Use a professional email address
   - Choose "Free" plan (sufficient for most sites)

2. **Verify your account**:
   - Check your email for verification link
   - Complete email verification
   - Consider enabling two-factor authentication for security

3. **Username considerations**:
   - Choose something professional if this is for business
   - Username becomes part of your GitHub Pages URL
   - Cannot be easily changed later
   - Examples: `lamoni-historical`, `lamoni-association`, `your-organization`

### Step 2: Create Repository

1. **Create new repository**:
   ```bash
   # Navigate to your Hugo site directory
   cd /Users/davidrichards/codes/lamoni
   
   # Initialize Git repository if not already done
   git init
   
   # Add all files
   git add .
   
   # Initial commit
   git commit -m "Initial Hugo site setup"
   ```

2. **Create repository on GitHub**:
   - Go to GitHub.com and click "New repository"
   - Repository name: `lamoni` (or `username.github.io` for user site)
   - Description: "Hugo website for Lamoni Historical Association"
   - Make it **Public** (required for free GitHub Pages)
   - **Don't** initialize with README (since you already have content)
   - Click "Create repository"

3. **Connect local repository to GitHub**:
   ```bash
   # Add GitHub as remote origin
   git remote add origin https://github.com/YOUR_USERNAME/lamoni.git
   
   # Push to GitHub
   git branch -M main
   git push -u origin main
   ```

## Option B: Using Existing GitHub Account

### Step 1: Assess Current Account

1. **Review existing repositories**:
   - Check if you already have a `username.github.io` repository
   - If yes, you'll need to create a project repository instead
   - Consider organization vs personal account usage

2. **Repository naming options**:
   - **User/Organization site**: `username.github.io` (only one per account)
   - **Project site**: `any-name` (unlimited, hosted at `username.github.io/repository-name`)

### Step 2: Create Repository

1. **For project repository** (recommended):
   ```bash
   # Navigate to your Hugo site
   cd /Users/davidrichards/codes/lamoni
   
   # Ensure Git is initialized
   git status
   
   # If not a Git repository, initialize
   git init
   git add .
   git commit -m "Initial Hugo site setup"
   ```

2. **Create repository on GitHub**:
   - Click "New repository" in your GitHub account
   - Name: `lamoni` (or your preferred site name)
   - Description: "Hugo website for Lamoni Historical Association"
   - Public repository
   - Don't initialize with README
   - Create repository

3. **Connect to GitHub**:
   ```bash
   # Add remote (replace with your actual username)
   git remote add origin https://github.com/YOUR_USERNAME/lamoni.git
   
   # Push to GitHub
   git branch -M main
   git push -u origin main
   ```

## Step 3: Configure GitHub Pages

### Enable GitHub Pages

1. **Navigate to repository settings**:
   - Go to your repository on GitHub
   - Click "Settings" tab
   - Scroll down to "Pages" in left sidebar

2. **Configure source**:
   - Source: "GitHub Actions" (recommended for Hugo)
   - This allows custom build processes

### Create GitHub Actions Workflow

1. **Create workflow directory**:
   ```bash
   mkdir -p .github/workflows
   ```

2. **Create Hugo deployment workflow** (`.github/workflows/hugo.yml`):
   ```yaml
   # Sample workflow for building and deploying a Hugo site to GitHub Pages
   name: Deploy Hugo site to Pages

   on:
     # Runs on pushes targeting the default branch
     push:
       branches:
         - main

     # Allows you to run this workflow manually from the Actions tab
     workflow_dispatch:

   # Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
   permissions:
     contents: read
     pages: write
     id-token: write

   # Allow only one concurrent deployment, skipping runs queued between the run in-progress and latest queued.
   # However, do NOT cancel in-progress runs as we want to allow these production deployments to complete.
   concurrency:
     group: "pages"
     cancel-in-progress: false

   # Default to bash
   defaults:
     run:
       shell: bash

   jobs:
     # Build job
     build:
       runs-on: ubuntu-latest
       env:
         HUGO_VERSION: 0.150.0
       steps:
         - name: Install Hugo CLI
           run: |
             wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb \
             && sudo dpkg -i ${{ runner.temp }}/hugo.deb          
         - name: Install Dart Sass
           run: sudo snap install dart-sass
         - name: Checkout
           uses: actions/checkout@v4
           with:
             submodules: recursive
             fetch-depth: 0
         - name: Setup Pages
           id: pages
           uses: actions/configure-pages@v4
         - name: Install Node.js dependencies
           run: "[[ -f package-lock.json || -f npm-shrinkwrap.json ]] && npm ci || true"
         - name: Build with Hugo
           env:
             # For maximum backward compatibility with Hugo modules
             HUGO_ENVIRONMENT: production
             HUGO_ENV: production
           run: |
             hugo \
               --gc \
               --minify \
               --baseURL "${{ steps.pages.outputs.base_url }}/"          
         - name: Upload artifact
           uses: actions/upload-pages-artifact@v2
           with:
             path: ./public

     # Deployment job
     deploy:
       environment:
         name: github-pages
         url: ${{ steps.deploy.outputs.page_url }}
       runs-on: ubuntu-latest
       needs: build
       steps:
         - name: Deploy to GitHub Pages
           id: deploy
           uses: actions/deploy-pages@v3
   ```

3. **Commit and push workflow**:
   ```bash
   git add .github/workflows/hugo.yml
   git commit -m "Add GitHub Pages deployment workflow"
   git push
   ```

## Step 4: Configure Hugo for GitHub Pages

### Update Hugo Configuration

1. **Update hugo.toml for GitHub Pages**:
   ```toml
   baseURL = 'https://YOUR_USERNAME.github.io/lamoni/'
   languageCode = 'en-us'
   title = 'Lamoni Historical Association'
   theme = 'ananke'

   # GitHub Pages specific settings
   canonifyurls = true
   relativeURLs = false

   [params]
     # Enable GitHub edit links
     githubRepo = "https://github.com/YOUR_USERNAME/lamoni"
     editPage = true
   ```

2. **Alternative for custom domain**:
   ```toml
   baseURL = 'https://lamonihistoricalassociation.org/'
   languageCode = 'en-us'
   title = 'Lamoni Historical Association'
   theme = 'ananke'

   # Custom domain settings
   canonifyurls = true
   ```

### Handle Theme Submodules

1. **Ensure theme is properly committed**:
   ```bash
   # Check if theme is a submodule
   git submodule status
   
   # If theme shows as modified, update it
   git submodule update --remote --merge
   
   # Commit any changes
   git add .
   git commit -m "Update theme submodule"
   git push
   ```

## Step 5: Custom Domain Setup (Optional)

### Option A: Using GitHub.io Subdomain

Your site will be available at:
- User site: `https://username.github.io`
- Project site: `https://username.github.io/repository-name`

No additional DNS setup required.

### Option B: Custom Domain

1. **Add CNAME file**:
   ```bash
   # Create CNAME file in static directory
   echo "lamonihistoricalassociation.org" > static/CNAME
   
   # Commit the change
   git add static/CNAME
   git commit -m "Add custom domain"
   git push
   ```

2. **Configure DNS with your domain provider**:

   **For apex domain (lamonihistoricalassociation.org)**:
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   Value: 185.199.109.153
   Value: 185.199.110.153
   Value: 185.199.111.153
   ```

   **For www subdomain**:
   ```
   Type: CNAME
   Name: www
   Value: YOUR_USERNAME.github.io
   ```

3. **Enable custom domain in GitHub**:
   - Go to repository Settings → Pages
   - Enter your custom domain: `lamonihistoricalassociation.org`
   - Enable "Enforce HTTPS" (after DNS propagates)

### DNS Provider Examples

**Cloudflare**:
1. Log into Cloudflare dashboard
2. Select your domain
3. Go to DNS records
4. Add the A records pointing to GitHub's IPs
5. Set proxy status to "DNS only" initially

**GoDaddy**:
1. Log into GoDaddy account
2. Go to DNS management
3. Add A records with GitHub's IP addresses
4. Add CNAME record for www

**Namecheap**:
1. Access your domain dashboard
2. Go to Advanced DNS
3. Add A records and CNAME as specified above

## Step 6: Verify Deployment

### Check GitHub Actions

1. **Monitor deployment**:
   - Go to your repository on GitHub
   - Click "Actions" tab
   - Watch the workflow run
   - Check for any errors in the build or deploy steps

2. **Common issues and solutions**:
   - **Theme not found**: Ensure submodule is properly initialized
   - **Build failures**: Check Hugo version in workflow matches your local version
   - **Permission errors**: Verify GitHub Pages is enabled and permissions are set

### Test Your Site

1. **Access your site**:
   - GitHub.io URL: `https://username.github.io/repository-name`
   - Custom domain: `https://yourdomain.com` (after DNS propagates)

2. **Verify functionality**:
   - All pages load correctly
   - Images and assets display properly
   - Links work as expected
   - Theme styling is applied
   - Forms submit correctly (if applicable)

## Step 7: Ongoing Management

### Regular Updates

1. **Content updates**:
   ```bash
   # Make changes to content
   hugo new content posts/new-post.md
   
   # Commit and push (triggers automatic deployment)
   git add .
   git commit -m "Add new blog post"
   git push
   ```

2. **Theme updates**:
   ```bash
   # Update theme submodule
   git submodule update --remote --merge
   git commit -am "Update theme"
   git push
   ```

### Branch Protection

1. **Protect main branch**:
   - Go to Settings → Branches
   - Add rule for `main` branch
   - Enable "Require status checks to pass"
   - Select "Deploy Hugo site to Pages" workflow

### Analytics and Monitoring

1. **Add Google Analytics** (optional):
   ```toml
   # In hugo.toml
   [params]
     googleAnalytics = "G-XXXXXXXXXX"
   ```

2. **Monitor site performance**:
   - Use GitHub's traffic insights
   - Set up Google Search Console
   - Monitor Core Web Vitals

## Troubleshooting

### Common Issues

1. **Site not updating**:
   - Check GitHub Actions for failed deployments
   - Verify CNAME file is correct
   - Clear browser cache

2. **Theme not displaying**:
   - Ensure theme submodule is initialized: `git submodule update --init --recursive`
   - Check theme name in hugo.toml matches directory name

3. **Custom domain not working**:
   - Verify DNS records are correct
   - Wait for DNS propagation (up to 48 hours)
   - Check CNAME file exists and contains correct domain

4. **Build failures**:
   - Check Hugo version compatibility
   - Verify all content has valid front matter
   - Test build locally: `hugo --gc --minify`

### Getting Help

1. **GitHub Support**:
   - GitHub Pages documentation
   - GitHub Community discussions
   - Repository issues for theme-specific problems

2. **Hugo Support**:
   - Hugo documentation
   - Hugo community forum
   - Hugo GitHub discussions

## Security Best Practices

1. **Repository access**:
   - Use strong passwords and 2FA
   - Limit collaborator access
   - Regular security audits

2. **Content security**:
   - Don't commit sensitive information
   - Use environment variables for secrets
   - Regular dependency updates

3. **Domain security**:
   - Enable HTTPS enforcement
   - Use reputable DNS providers
   - Monitor domain expiration

## Cost Considerations

- **GitHub Pages**: Free for public repositories
- **Custom domain**: Annual registration fee (varies by TLD)
- **DNS services**: Often included with domain registration
- **Premium features**: GitHub Pro for private repositories ($4/month)

This setup provides a robust, professional hosting solution for your Hugo site with automatic deployments and the ability to use a custom domain.
