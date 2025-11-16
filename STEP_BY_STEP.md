# Step-by-Step: Option 1 Setup

## Step 1: Install GitHub CLI

### Method A: Download Installer (Recommended)
1. Open your browser and go to: **https://cli.github.com/**
2. Click **"Download for macOS"**
3. Open the downloaded `.pkg` file
4. Follow the installation wizard
5. Come back here when done!

### Method B: Using Homebrew (if available)
```bash
brew install gh
```

## Step 2: Verify Installation

After installation, run this command to verify:
```bash
gh --version
```

You should see something like: `gh version 2.x.x`

## Step 3: Authenticate

Once GitHub CLI is installed, run:
```bash
gh auth login
```

Follow the prompts:
- Choose "GitHub.com"
- Choose "HTTPS" or "SSH" (HTTPS is easier)
- Authenticate via web browser or token

Then authenticate with Vercel:
```bash
vercel login
```

## Step 4: Run Automated Setup

Once both are authenticated, run:
```bash
./scripts/auto-deploy.sh
```

---

**Let me know when you've completed Step 1 (installing GitHub CLI), and I'll help you with the rest!**

