# Install Homebrew

Homebrew requires administrator access and password input, so you'll need to run this command in your terminal.

## Installation Command

Open your terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This will:
1. Ask for your password (for sudo access)
2. Install Homebrew to `/opt/homebrew` (on Apple Silicon) or `/usr/local` (on Intel)
3. Add Homebrew to your PATH

## After Installation

After Homebrew is installed, you may need to add it to your PATH. The installer will show you the commands to run, but typically it's:

**For Apple Silicon Macs:**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**For Intel Macs:**
```bash
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

## Verify Installation

After installation, verify it works:

```bash
brew --version
```

## Then Install GitHub CLI

Once Homebrew is installed, you can install GitHub CLI:

```bash
brew install gh
```

## Let Me Know When Done

After you've installed Homebrew and GitHub CLI, let me know and I'll help you:
1. Authenticate with GitHub and Vercel
2. Run the automated deployment setup
3. Complete the deployment configuration

