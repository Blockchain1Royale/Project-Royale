#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting documentation sync process...${NC}"

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

# Check if there are any changes
if [[ -n $(git status -s) ]]; then
    echo -e "${GREEN}Changes detected in documentation...${NC}"
    
    # Stage all changes in docs directory
    git add docs/
    
    # Stage GitBook configuration if changed
    git add .gitbook.yaml
    
    # Commit changes with timestamp
    commit_message="docs: auto-sync documentation $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$commit_message"
    
    # Push changes
    if git push origin main; then
        echo -e "${GREEN}Successfully pushed documentation changes${NC}"
    else
        echo -e "${RED}Failed to push changes${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}No changes detected in documentation${NC}"
fi

# Trigger GitBook webhook if configured
if [ -n "$GITBOOK_WEBHOOK_URL" ]; then
    echo -e "${GREEN}Triggering GitBook webhook...${NC}"
    curl -X POST "$GITBOOK_WEBHOOK_URL"
fi

echo -e "${GREEN}Documentation sync completed${NC}" 