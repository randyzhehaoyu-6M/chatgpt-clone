# Vercel Linking Guide

Since Vercel authentication requires interactive input, here's how to complete the linking:

## Step 1: Link Vercel Project

Run this command in your terminal:

```bash
cd /Users/zhehaoyu/Documents/Cursor-Tutorial
./link-vercel.sh
```

Or manually:
```bash
vercel link
```

When prompted:
1. **Select your Vercel account** (choose the account you authenticated with)
2. **Link to existing project or create new:**
   - If you want to create a new project: Select "Create a new project"
   - If you have an existing project: Select "Link to existing project"
3. **Project name:** Use `chatgpt-clone` or accept the default
4. **Accept defaults** for other settings

This will create `.vercel/project.json` with your project configuration.

## Step 2: Get Vercel Token

1. Go to: **https://vercel.com/account/tokens**
2. Click **"Create Token"**
3. Name it: `GitHub Actions` (or any name you prefer)
4. **Copy the token** (you'll only see it once!)

## Step 3: Set Vercel Secrets

After you have the token, run:

```bash
cd /Users/zhehaoyu/Documents/Cursor-Tutorial
VERCEL_TOKEN='your-token-here' ./setup-vercel-secrets.sh
```

Replace `your-token-here` with the token you copied.

Or run the script and it will prompt you:
```bash
./setup-vercel-secrets.sh
```

## Step 4: Test Deployment

After all secrets are set, trigger a deployment:

```bash
git commit --allow-empty -m "Trigger deployment"
git push
```

Then check:
- **GitHub Actions**: https://github.com/randyzhehaoyu-6M/chatgpt-clone/actions
- **Vercel Dashboard**: https://vercel.com/dashboard

## ✅ That's It!

Once complete, every push to `main` will automatically deploy to Vercel!

