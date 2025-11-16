# Install GitHub CLI

To complete the automated deployment setup, you need to install GitHub CLI.

## Installation Options

### Option 1: Download Installer (Easiest for macOS)

1. Visit: https://cli.github.com/
2. Click "Download for macOS"
3. Open the downloaded `.pkg` file
4. Follow the installation wizard
5. Verify installation:
   ```bash
   gh --version
   ```

### Option 2: Using Homebrew (if you have it)

```bash
brew install gh
```

### Option 3: Using MacPorts (if you have it)

```bash
sudo port install gh
```

## After Installation

1. **Authenticate:**
   ```bash
   gh auth login
   ```
   Follow the prompts to authenticate with GitHub.

2. **Then run the setup:**
   ```bash
   ./scripts/auto-deploy.sh
   ```

## Alternative: Manual Setup Without GitHub CLI

If you prefer not to install GitHub CLI, you can:

1. Create the repository manually on GitHub.com
2. Push your code manually
3. Set up secrets manually in GitHub repository settings
4. The GitHub Actions workflow will still work automatically!

Let me know which approach you prefer!

