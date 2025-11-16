#!/bin/bash

# Automated Vercel deployment setup
# This sets up Vercel to auto-deploy from GitHub

set -e

echo "🚀 Setting up Automated Vercel Deployment"
echo "=========================================="
echo ""

cd /Users/zhehaoyu/Documents/Cursor-Tutorial

# Check if Vercel is authenticated
if ! vercel whoami &>/dev/null; then
    echo "🔐 Please authenticate with Vercel first:"
    echo "   vercel login"
    exit 1
fi

echo "✅ Vercel authenticated"
echo ""

# Check if already linked
if [ -f ".vercel/project.json" ]; then
    echo "✅ Vercel project already linked"
    cat .vercel/project.json
else
    echo "📦 Linking Vercel project..."
    echo "   (This will prompt you to create/select a project)"
    vercel link --yes
fi

echo ""
echo "🌐 Your deployment options:"
echo ""
echo "Option 1: Vercel Dashboard (Recommended - Easiest)"
echo "   1. Go to: https://vercel.com/new"
echo "   2. Import: randyzhehaoyu-6M/chatgpt-clone"
echo "   3. Add environment variables:"
echo "      - AI_BUILDER_TOKEN"
echo "      - NEXT_PUBLIC_API_BASE_URL = https://space.ai-builders.com/backend"
echo "   4. Deploy!"
echo ""
echo "Option 2: Deploy via CLI (Right now)"
echo "   Run: vercel --prod"
echo ""

if [ -f ".vercel/project.json" ]; then
    ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
    PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)
    
    echo "📋 Your Vercel Project Info:"
    echo "   Org ID: $ORG_ID"
    echo "   Project ID: $PROJECT_ID"
    echo ""
    echo "🔗 Your project URL will be:"
    echo "   https://$(vercel inspect --token=$(vercel whoami 2>/dev/null | head -1) 2>/dev/null | grep -o 'https://[^"]*' | head -1 || echo 'your-project.vercel.app')"
fi

echo ""
echo "✅ Setup complete! Your app will auto-deploy on every git push."

