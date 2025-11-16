# Deployment Guide

## Option 1: Deploy to Vercel (Recommended for Next.js)

Vercel is the easiest and most optimized platform for Next.js applications.

### Steps:

1. **Install Vercel CLI** (if not already installed):
   ```bash
   npm i -g vercel
   ```

2. **Login to Vercel**:
   ```bash
   vercel login
   ```

3. **Deploy**:
   ```bash
   vercel
   ```
   Follow the prompts. When asked about environment variables, add:
   - `AI_BUILDER_TOKEN` - Your AI Builder API token
   - `NEXT_PUBLIC_API_BASE_URL` - `https://space.ai-builders.com/backend`

4. **Or deploy via Vercel Dashboard**:
   - Go to https://vercel.com
   - Click "New Project"
   - Import your GitHub repository
   - Add environment variables:
     - `AI_BUILDER_TOKEN`
     - `NEXT_PUBLIC_API_BASE_URL` = `https://space.ai-builders.com/backend`
   - Click "Deploy"

### Environment Variables Required:
- `AI_BUILDER_TOKEN` - Your AI Builder API token (get it from the AI Builders platform)
- `NEXT_PUBLIC_API_BASE_URL` - Set to `https://space.ai-builders.com/backend`

## Option 2: Deploy to GitHub and use Vercel

1. **Create a GitHub repository**:
   ```bash
   # Create a new repo on GitHub, then:
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git branch -M main
   git push -u origin main
   ```

2. **Connect to Vercel**:
   - Go to https://vercel.com
   - Import your GitHub repository
   - Add environment variables
   - Deploy

## Option 3: Deploy using AI Builders Platform

If you want to use the AI Builders deployment system, you'll need to:
1. Push your code to a public GitHub repository
2. Create a Dockerfile for Next.js
3. Use the deployment API

Let me know which option you prefer!

