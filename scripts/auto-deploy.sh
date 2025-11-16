#!/bin/bash

# Complete automated deployment script
# This script handles the entire deployment process

set -e

echo "🚀 Automated Deployment Script"
echo "================================"
echo ""

# Step 1: Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v git &> /dev/null; then
    echo "❌ Git not found. Please install Git."
    exit 1
fi

if ! command -v gh &> /dev/null; then
    echo "📦 Installing GitHub CLI..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install gh
    else
        echo "Please install GitHub CLI: https://cli.github.com/"
        exit 1
    fi
fi

if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

echo "✅ All prerequisites met"
echo ""

# Step 2: Check if logged in
echo "🔐 Checking authentication..."

if ! gh auth status &> /dev/null; then
    echo "Please login to GitHub..."
    gh auth login
fi

if ! vercel whoami &> /dev/null; then
    echo "Please login to Vercel..."
    vercel login
fi

echo "✅ Authenticated"
echo ""

# Step 3: Check if repository exists
REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")

if [ -z "$REPO_URL" ]; then
    echo "📦 Creating GitHub repository..."
    echo "Enter repository name (or press Enter for 'chatgpt-clone'):"
    read REPO_NAME
    REPO_NAME=${REPO_NAME:-chatgpt-clone}
    
    echo "Creating repository: $REPO_NAME"
    gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
    
    REPO_URL=$(git remote get-url origin)
    echo "✅ Repository created: $REPO_URL"
else
    echo "✅ Repository already exists: $REPO_URL"
    
    # Push if there are uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        echo "📤 Committing and pushing changes..."
        git add .
        git commit -m "Update: automated deployment setup" || true
        git push origin main
    fi
fi

echo ""

# Step 4: Set up Vercel project
if [ ! -d ".vercel" ]; then
    echo "🔗 Linking Vercel project..."
    vercel link --yes
else
    echo "✅ Vercel project already linked"
fi

echo ""

# Step 5: Configure secrets
echo "🔑 Configuring GitHub secrets..."
REPO=$(echo "$REPO_URL" | sed -E 's/.*github.com[:/]([^/]+\/[^/]+)\.git/\1/')

# Get AI_BUILDER_TOKEN
if [ -f .env.local ]; then
    AI_BUILDER_TOKEN=$(grep AI_BUILDER_TOKEN .env.local | cut -d '=' -f2 | tr -d ' ' || echo "")
fi

if [ -z "$AI_BUILDER_TOKEN" ]; then
    echo "Enter your AI_BUILDER_TOKEN:"
    read -s AI_BUILDER_TOKEN
fi

if [ -n "$AI_BUILDER_TOKEN" ]; then
    echo "$AI_BUILDER_TOKEN" | gh secret set AI_BUILDER_TOKEN --repo "$REPO" 2>/dev/null || true
    echo "✅ Set AI_BUILDER_TOKEN"
fi

echo "https://space.ai-builders.com/backend" | gh secret set NEXT_PUBLIC_API_BASE_URL --repo "$REPO" 2>/dev/null || true
echo "✅ Set NEXT_PUBLIC_API_BASE_URL"

# Get Vercel secrets
if [ -f ".vercel/project.json" ]; then
    VERCEL_ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
    VERCEL_PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)
    
    echo "Enter your Vercel token (get it from https://vercel.com/account/tokens):"
    read -s VERCEL_TOKEN
    
    if [ -n "$VERCEL_TOKEN" ]; then
        echo "$VERCEL_TOKEN" | gh secret set VERCEL_TOKEN --repo "$REPO" 2>/dev/null || true
        echo "$VERCEL_ORG_ID" | gh secret set VERCEL_ORG_ID --repo "$REPO" 2>/dev/null || true
        echo "$VERCEL_PROJECT_ID" | gh secret set VERCEL_PROJECT_ID --repo "$REPO" 2>/dev/null || true
        echo "✅ Set Vercel secrets"
    fi
fi

echo ""
echo "✅ Automated deployment setup complete!"
echo ""
echo "🎉 Your project is now set up for automatic deployment!"
echo "   Every push to 'main' will automatically deploy to Vercel."
echo ""
echo "📝 Next steps:"
echo "   1. Make changes to your code"
echo "   2. Commit: git commit -am 'Your message'"
echo "   3. Push: git push"
echo "   4. Watch the deployment at: https://github.com/$REPO/actions"

