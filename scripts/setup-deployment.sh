#!/bin/bash

# Automated deployment setup script
# This script helps set up automatic deployment to Vercel via GitHub Actions

set -e

echo "🚀 Setting up automated deployment..."
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "📦 Installing GitHub CLI..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install gh
    else
        echo "Please install GitHub CLI manually: https://cli.github.com/"
        exit 1
    fi
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

echo "✅ Required tools are installed"
echo ""

# Check if already logged in to GitHub
if ! gh auth status &> /dev/null; then
    echo "🔐 Please login to GitHub..."
    gh auth login
fi

# Check if already logged in to Vercel
if ! vercel whoami &> /dev/null; then
    echo "🔐 Please login to Vercel..."
    vercel login
fi

echo ""
echo "📋 Next steps:"
echo "1. Create a GitHub repository (or use existing)"
echo "2. Push your code to GitHub"
echo "3. Set up Vercel project and get tokens"
echo "4. Add secrets to GitHub repository"
echo ""
echo "Run './scripts/configure-secrets.sh' after pushing to GitHub to set up secrets automatically"

