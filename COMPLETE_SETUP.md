# Complete the Deployment Setup

Great progress! Your code is now on GitHub and some secrets are configured. Here's what's left:

## ✅ Completed:
- ✅ GitHub repository created: https://github.com/randyzhehaoyu-6M/chatgpt-clone
- ✅ Code pushed to GitHub
- ✅ GitHub secrets configured:
  - `AI_BUILDER_TOKEN`
  - `NEXT_PUBLIC_API_BASE_URL`

## 🔧 Remaining Steps:

### 1. Link Vercel Project

Run this command in your terminal:
```bash
cd /Users/zhehaoyu/Documents/Cursor-Tutorial
vercel link
```

When prompted:
- Select your Vercel account
- Create a new project or link to existing
- Accept defaults for project settings

This will create `.vercel/project.json` with your project IDs.

### 2. Get Vercel Token

1. Go to: https://vercel.com/account/tokens
2. Click "Create Token"
3. Name it (e.g., "GitHub Actions")
4. Copy the token

### 3. Set Vercel Secrets in GitHub

After linking Vercel, you'll have a `.vercel/project.json` file. Then run:

```bash
# Get your Vercel token from step 2, then:
VERCEL_TOKEN="your-token-here"
ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)

echo "$VERCEL_TOKEN" | gh secret set VERCEL_TOKEN --repo randyzhehaoyu-6M/chatgpt-clone
echo "$ORG_ID" | gh secret set VERCEL_ORG_ID --repo randyzhehaoyu-6M/chatgpt-clone
echo "$PROJECT_ID" | gh secret set VERCEL_PROJECT_ID --repo randyzhehaoyu-6M/chatgpt-clone
```

### 4. Test the Deployment

After all secrets are set, push a commit to trigger the GitHub Actions workflow:

```bash
git commit --allow-empty -m "Trigger deployment"
git push
```

Then check the deployment:
- GitHub Actions: https://github.com/randyzhehaoyu-6M/chatgpt-clone/actions
- Vercel Dashboard: https://vercel.com/dashboard

## 🎉 You're Almost There!

Once you complete steps 1-3, your automated deployment will be fully set up. Every push to `main` will automatically deploy to Vercel!

