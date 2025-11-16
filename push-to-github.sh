#!/bin/bash

# Script to push code to GitHub
# Usage: ./push-to-github.sh YOUR_GITHUB_REPO_URL

if [ -z "$1" ]; then
    echo "Usage: ./push-to-github.sh YOUR_GITHUB_REPO_URL"
    echo "Example: ./push-to-github.sh https://github.com/username/chatgpt-clone.git"
    exit 1
fi

REPO_URL=$1

echo "Setting up GitHub repository..."
echo "Repository URL: $REPO_URL"
echo ""

# Check if remote already exists
if git remote get-url origin > /dev/null 2>&1; then
    echo "Remote 'origin' already exists. Updating..."
    git remote set-url origin "$REPO_URL"
else
    echo "Adding remote 'origin'..."
    git remote add origin "$REPO_URL"
fi

echo ""
echo "Pushing code to GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo "Your repository is now available at: $REPO_URL"
else
    echo ""
    echo "❌ Error pushing to GitHub. Please check:"
    echo "1. The repository URL is correct"
    echo "2. You have access to the repository"
    echo "3. You're authenticated with GitHub (may need to set up SSH keys or use GitHub CLI)"
fi

