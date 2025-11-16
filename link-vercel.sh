#!/bin/bash

# Helper script to link Vercel project and set up secrets

set -e

echo "🔗 Linking Vercel Project"
echo "========================"
echo ""

cd /Users/zhehaoyu/Documents/Cursor-Tutorial

# Check if already linked
if [ -f ".vercel/project.json" ]; then
    echo "✅ Vercel project already linked!"
    cat .vercel/project.json
    echo ""
    echo "If you want to re-link, delete .vercel directory first: rm -rf .vercel"
    exit 0
fi

# Link Vercel project
echo "Running: vercel link"
echo ""
vercel link

# Check if linking was successful
if [ -f ".vercel/project.json" ]; then
    echo ""
    echo "✅ Vercel project linked successfully!"
    echo ""
    echo "Project configuration:"
    cat .vercel/project.json
    echo ""
    
    # Extract IDs
    ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
    PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)
    
    echo "📋 Your Vercel IDs:"
    echo "   Org ID: $ORG_ID"
    echo "   Project ID: $PROJECT_ID"
    echo ""
    echo "🔑 Next steps:"
    echo "1. Get your Vercel token from: https://vercel.com/account/tokens"
    echo "2. Then run this script to set up secrets:"
    echo ""
    echo "   VERCEL_TOKEN='your-token-here' ./setup-vercel-secrets.sh"
    echo ""
    echo "Or manually set the secrets:"
    echo "   echo \"\$VERCEL_TOKEN\" | gh secret set VERCEL_TOKEN --repo randyzhehaoyu-6M/chatgpt-clone"
    echo "   echo \"$ORG_ID\" | gh secret set VERCEL_ORG_ID --repo randyzhehaoyu-6M/chatgpt-clone"
    echo "   echo \"$PROJECT_ID\" | gh secret set VERCEL_PROJECT_ID --repo randyzhehaoyu-6M/chatgpt-clone"
else
    echo "❌ Failed to link Vercel project"
    exit 1
fi

