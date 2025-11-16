#!/bin/bash

# Script to configure GitHub secrets for automated deployment
# Usage: ./scripts/configure-secrets.sh

set -e

echo "🔐 Configuring GitHub Secrets for Automated Deployment"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found. Please install it first:"
    echo "   brew install gh"
    exit 1
fi

# Check if logged in
if ! gh auth status &> /dev/null; then
    echo "❌ Not logged in to GitHub. Please run: gh auth login"
    exit 1
fi

# Get repository name
REPO=$(git remote get-url origin 2>/dev/null | sed -E 's/.*github.com[:/]([^/]+\/[^/]+)\.git/\1/' || echo "")
if [ -z "$REPO" ]; then
    echo "❌ Could not detect GitHub repository."
    echo "   Please make sure you've added a remote: git remote add origin <url>"
    exit 1
fi

echo "📦 Repository: $REPO"
echo ""

# Get AI_BUILDER_TOKEN
if [ -f .env.local ]; then
    AI_BUILDER_TOKEN=$(grep AI_BUILDER_TOKEN .env.local | cut -d '=' -f2 | tr -d ' ' || echo "")
fi

if [ -z "$AI_BUILDER_TOKEN" ]; then
    echo "Enter your AI_BUILDER_TOKEN:"
    read -s AI_BUILDER_TOKEN
fi

# Set API Base URL
NEXT_PUBLIC_API_BASE_URL="https://space.ai-builders.com/backend"

echo ""
echo "🔑 Setting up GitHub secrets..."

# Set AI_BUILDER_TOKEN
if [ -n "$AI_BUILDER_TOKEN" ]; then
    echo "$AI_BUILDER_TOKEN" | gh secret set AI_BUILDER_TOKEN --repo "$REPO"
    echo "✅ Set AI_BUILDER_TOKEN"
fi

# Set NEXT_PUBLIC_API_BASE_URL
echo "$NEXT_PUBLIC_API_BASE_URL" | gh secret set NEXT_PUBLIC_API_BASE_URL --repo "$REPO"
echo "✅ Set NEXT_PUBLIC_API_BASE_URL"

echo ""
echo "📝 Next, set up Vercel secrets:"
echo ""
echo "1. Get your Vercel tokens:"
echo "   - Go to https://vercel.com/account/tokens"
echo "   - Create a new token"
echo "   - Run: vercel link (in your project directory)"
echo "   - This will create .vercel/project.json with your org and project IDs"
echo ""
echo "2. Set Vercel secrets:"
echo "   gh secret set VERCEL_TOKEN --repo $REPO"
echo "   gh secret set VERCEL_ORG_ID --repo $REPO"
echo "   gh secret set VERCEL_PROJECT_ID --repo $REPO"
echo ""
echo "Or run: ./scripts/setup-vercel-secrets.sh"

