# GitHub Repository Setup Guide

## Step 1: Create a GitHub Repository

1. Go to https://github.com and sign in (or create an account if you don't have one)
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. Fill in the details:
   - **Repository name**: `chatgpt-clone` (or any name you prefer)
   - **Description**: "A ChatGPT-like interface built with Next.js and AI Builders API"
   - **Visibility**: Choose "Public" (required for free Vercel deployment) or "Private"
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
5. Click "Create repository"

## Step 2: Copy Your Repository URL

After creating the repository, GitHub will show you a page with setup instructions. Copy the repository URL. It will look like:
- `https://github.com/YOUR_USERNAME/chatgpt-clone.git` (HTTPS)
- or `git@github.com:YOUR_USERNAME/chatgpt-clone.git` (SSH)

## Step 3: Connect and Push Your Code

Once you have the repository URL, come back here and I'll help you push the code!

---

**Quick Command Reference** (after you have the URL):

```bash
git remote add origin YOUR_REPOSITORY_URL
git branch -M main
git push -u origin main
```

Replace `YOUR_REPOSITORY_URL` with the URL from Step 2.

