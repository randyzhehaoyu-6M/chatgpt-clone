# Quick Setup Guide

Since GitHub CLI needs to be installed manually, here's a streamlined approach:

## Step 1: Install GitHub CLI

**On macOS:**
```bash
# Option 1: Using Homebrew (if you have it)
brew install gh

# Option 2: Download from GitHub
# Visit: https://cli.github.com/
# Or use the installer:
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
```

**Or download directly:**
- Visit: https://github.com/cli/cli/releases
- Download the macOS installer
- Install the .pkg file

## Step 2: Authenticate

```bash
gh auth login
```

Follow the prompts to authenticate with GitHub.

## Step 3: Run the Setup

Once GitHub CLI is installed and authenticated, run:

```bash
./scripts/auto-deploy.sh
```

## Alternative: Manual Setup

If you prefer to set things up manually:

1. **Create GitHub repository:**
   ```bash
   gh repo create chatgpt-clone --public --source=. --remote=origin --push
   ```

2. **Link Vercel:**
   ```bash
   vercel link
   ```

3. **Configure secrets:**
   ```bash
   ./scripts/configure-secrets.sh
   ./scripts/setup-vercel-secrets.sh
   ```

That's it! After this, every `git push` will automatically deploy.

