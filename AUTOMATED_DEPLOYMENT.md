# Automated Deployment Guide

This project is set up for **automatic deployment** to Vercel whenever you push code to GitHub!

## 🚀 Quick Start (One-Time Setup)

Run the automated setup script:

```bash
./scripts/auto-deploy.sh
```

This script will:
1. ✅ Check and install required tools (GitHub CLI, Vercel CLI)
2. ✅ Create a GitHub repository (if needed)
3. ✅ Link your Vercel project
4. ✅ Configure all GitHub secrets
5. ✅ Set up GitHub Actions workflow

## 📋 Manual Setup (Step by Step)

If you prefer to set things up manually:

### 1. Install Required Tools

```bash
# Install GitHub CLI
brew install gh

# Install Vercel CLI
npm install -g vercel
```

### 2. Authenticate

```bash
# Login to GitHub
gh auth login

# Login to Vercel
vercel login
```

### 3. Create GitHub Repository

```bash
# Option A: Create via GitHub CLI
gh repo create chatgpt-clone --public --source=. --remote=origin --push

# Option B: Create on GitHub.com, then:
git remote add origin https://github.com/YOUR_USERNAME/chatgpt-clone.git
git push -u origin main
```

### 4. Link Vercel Project

```bash
vercel link
```

This creates `.vercel/project.json` with your project IDs.

### 5. Configure GitHub Secrets

```bash
# Set up all secrets at once
./scripts/configure-secrets.sh

# Or set up Vercel secrets separately
./scripts/setup-vercel-secrets.sh
```

**Required Secrets:**
- `AI_BUILDER_TOKEN` - Your AI Builder API token
- `NEXT_PUBLIC_API_BASE_URL` - `https://space.ai-builders.com/backend`
- `VERCEL_TOKEN` - Get from https://vercel.com/account/tokens
- `VERCEL_ORG_ID` - From `.vercel/project.json`
- `VERCEL_PROJECT_ID` - From `.vercel/project.json`

## 🔄 How It Works

1. **GitHub Actions Workflow** (`.github/workflows/deploy.yml`)
   - Triggers on every push to `main` branch
   - Builds your Next.js app
   - Deploys to Vercel automatically

2. **Automatic Deployment**
   - Push code → GitHub Actions runs → Vercel deploys
   - No manual steps needed after initial setup!

## 📝 Usage

After setup, deployment is automatic:

```bash
# Make changes to your code
git add .
git commit -m "Update feature"
git push
# 🚀 Deployment happens automatically!
```

## 🔍 Monitoring

- **GitHub Actions**: https://github.com/YOUR_USERNAME/chatgpt-clone/actions
- **Vercel Dashboard**: https://vercel.com/dashboard

## 🛠️ Troubleshooting

### Check GitHub Actions Status
```bash
gh run list
gh run watch
```

### View Logs
```bash
gh run view --log
```

### Re-run Failed Deployment
```bash
gh run rerun <run-id>
```

### Update Secrets
```bash
# Update a secret
echo "new-value" | gh secret set SECRET_NAME --repo YOUR_USERNAME/chatgpt-clone
```

## 📚 Scripts Reference

- `./scripts/auto-deploy.sh` - Complete automated setup
- `./scripts/configure-secrets.sh` - Set up GitHub secrets
- `./scripts/setup-vercel-secrets.sh` - Set up Vercel-specific secrets
- `./scripts/setup-deployment.sh` - Check prerequisites and guide setup

## 🎯 Benefits

✅ **Zero-touch deployment** - Push code, it deploys automatically  
✅ **CI/CD pipeline** - Builds and tests before deployment  
✅ **Production-ready** - Deploys to Vercel production environment  
✅ **Rollback support** - Easy to revert via Vercel dashboard  
✅ **Monitoring** - Track deployments in GitHub Actions

