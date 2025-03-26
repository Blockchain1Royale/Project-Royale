#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "🚀 Starting Project Royale auto-update..."

# Update documentation
echo "📚 Updating documentation..."
cd docs
gitbook build
if [ $? -eq 0 ]; then
    echo "${GREEN}✓ Documentation updated successfully${NC}"
else
    echo "${RED}✗ Documentation update failed${NC}"
fi

# Update dependencies
echo "📦 Updating dependencies..."
npm install
if [ $? -eq 0 ]; then
    echo "${GREEN}✓ Dependencies updated successfully${NC}"
else
    echo "${RED}✗ Dependencies update failed${NC}"
fi

# Update Unreal Engine project
echo "🎮 Checking for UE5 updates..."
# Add UE5 update commands here

# Update smart contracts
echo "🔗 Updating smart contracts..."
cd ../blockchain
anchor build
if [ $? -eq 0 ]; then
    echo "${GREEN}✓ Smart contracts updated successfully${NC}"
else
    echo "${RED}✗ Smart contracts update failed${NC}"
fi

# Git operations
echo "📤 Pushing updates to repository..."
git add .
git commit -m "auto: Documentation and dependency updates"
git push

echo "✨ Auto-update complete!" 