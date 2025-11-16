#!/bin/bash

# Script to set up Vercel secrets in GitHub

set -e

cd /Users/zhehaoyu/Documents/Cursor-Tutorial

# Check if Vercel is linked
if [ ! -f ".vercel/project.json" ]; then
    echo "❌ Vercel project not linked yet!"
    echo "   Run: ./link-vercel.sh first"
    exit 1
fi

# Get Vercel token from environment or prompt
if [ -z "$VERCEL_TOKEN" ]; then
    echo "Enter your Vercel token (get it from https://vercel.com/account/tokens):"
    read -s VERCEL_TOKEN
    echo ""
fi

if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ Vercel token is required"
    exit 1
fi

# Extract IDs from project.json
ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)

if [ -z "$ORG_ID" ] || [ -z "$PROJECT_ID" ]; then
    echo "❌ Could not extract Org ID or Project ID from .vercel/project.json"
    exit 1
fi

echo "🔑 Setting up Vercel secrets in GitHub..."
echo ""

# Set secrets
echo "$VERCEL_TOKEN" | gh secret set VERCEL_TOKEN --repo randyzhehaoyu-6M/chatgpt-clone
echo "✅ Set VERCEL_TOKEN"

echo "$ORG_ID" | gh secret set VERCEL_ORG_ID --repo randyzhehaoyu-6M/chatgpt-clone
echo "✅ Set VERCEL_ORG_ID"

echo "$PROJECT_ID" | gh secret set VERCEL_PROJECT_ID --repo randyzhehaoyu-6M/chatgpt-clone
echo "✅ Set VERCEL_PROJECT_ID"

echo ""
echo "🎉 All Vercel secrets configured!"
echo ""
echo "📋 Verify secrets:"
gh secret list --repo randyzhehaoyu-6M/chatgpt-clone
echo ""
echo "🚀 Your automated deployment is now fully set up!"
echo "   Push a commit to trigger deployment:"
echo "   git commit --allow-empty -m 'Trigger deployment' && git push"

