#!/bin/bash

# Script to set up Vercel secrets for GitHub Actions
# Usage: ./scripts/setup-vercel-secrets.sh

set -e

echo "🔐 Setting up Vercel Secrets for GitHub Actions"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found. Please install it first:"
    echo "   brew install gh"
    exit 1
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Please install it first:"
    echo "   npm install -g vercel"
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

# Check if .vercel directory exists
if [ ! -d ".vercel" ]; then
    echo "🔗 Linking Vercel project..."
    vercel link
fi

# Read Vercel config
if [ -f ".vercel/project.json" ]; then
    VERCEL_ORG_ID=$(cat .vercel/project.json | grep -o '"orgId":"[^"]*' | cut -d'"' -f4)
    VERCEL_PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId":"[^"]*' | cut -d'"' -f4)
    
    echo "✅ Found Vercel project configuration"
    echo "   Org ID: $VERCEL_ORG_ID"
    echo "   Project ID: $VERCEL_PROJECT_ID"
    echo ""
else
    echo "❌ Could not find .vercel/project.json"
    echo "   Please run: vercel link"
    exit 1
fi

# Get Vercel token
echo "Enter your Vercel token (get it from https://vercel.com/account/tokens):"
read -s VERCEL_TOKEN

if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ Vercel token is required"
    exit 1
fi

echo ""
echo "🔑 Setting up GitHub secrets..."

# Set Vercel secrets
echo "$VERCEL_TOKEN" | gh secret set VERCEL_TOKEN --repo "$REPO"
echo "✅ Set VERCEL_TOKEN"

echo "$VERCEL_ORG_ID" | gh secret set VERCEL_ORG_ID --repo "$REPO"
echo "✅ Set VERCEL_ORG_ID"

echo "$VERCEL_PROJECT_ID" | gh secret set VERCEL_PROJECT_ID --repo "$REPO"
echo "✅ Set VERCEL_PROJECT_ID"

echo ""
echo "✅ All Vercel secrets configured!"
echo ""
echo "🚀 Your automated deployment is now set up!"
echo "   Every push to the 'main' branch will automatically deploy to Vercel."

