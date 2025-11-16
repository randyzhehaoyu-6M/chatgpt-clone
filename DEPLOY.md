# Quick Deployment Guide

## Deploy to Vercel (Easiest Method)

### Step 1: Push to GitHub

First, create a GitHub repository and push your code:

```bash
# Create a new repository on GitHub first, then:
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

### Step 2: Deploy via Vercel Dashboard

1. Go to https://vercel.com and sign up/login
2. Click "Add New..." → "Project"
3. Import your GitHub repository
4. Configure the project:
   - **Framework Preset**: Next.js (auto-detected)
   - **Root Directory**: `./` (default)
   - **Build Command**: `npm run build` (default)
   - **Output Directory**: `.next` (default)

5. **Add Environment Variables**:
   - Click "Environment Variables"
   - Add these two:
     - Name: `AI_BUILDER_TOKEN`
       Value: `sk_564e0ec7_05b965ec7494ea05a998e879a85358c4456f`
     - Name: `NEXT_PUBLIC_API_BASE_URL`
       Value: `https://space.ai-builders.com/backend`

6. Click "Deploy"

Your app will be live at `https://your-project-name.vercel.app` in a few minutes!

## Alternative: Deploy via CLI

If you prefer using the command line:

```bash
# Login to Vercel
vercel login

# Deploy (it will prompt for environment variables)
vercel

# For production deployment
vercel --prod
```

When prompted, add the environment variables:
- `AI_BUILDER_TOKEN`
- `NEXT_PUBLIC_API_BASE_URL`

## Important Notes

- Your code is already committed to git
- Make sure `.env.local` is in `.gitignore` (it already is)
- The environment variables will be set in Vercel's dashboard, not in your code
- After deployment, your app will be accessible publicly

