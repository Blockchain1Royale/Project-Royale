#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Version file
VERSION_FILE="./docs/VERSION"
CHANGELOG_FILE="./docs/CHANGELOG.md"

# Read current version
if [ -f "$VERSION_FILE" ]; then
    CURRENT_VERSION=$(cat "$VERSION_FILE")
else
    CURRENT_VERSION="0.1.0"
fi

# Parse version components
MAJOR=$(echo "$CURRENT_VERSION" | cut -d. -f1)
MINOR=$(echo "$CURRENT_VERSION" | cut -d. -f2)
PATCH=$(echo "$CURRENT_VERSION" | cut -d. -f3)

# Function to update version
update_version() {
    local type=$1
    case $type in
        major)
            MAJOR=$((MAJOR + 1))
            MINOR=0
            PATCH=0
            ;;
        minor)
            MINOR=$((MINOR + 1))
            PATCH=0
            ;;
        patch)
            PATCH=$((PATCH + 1))
            ;;
    esac
    NEW_VERSION="$MAJOR.$MINOR.$PATCH"
}

# Get commit messages since last version
get_changes() {
    git log --pretty=format:"- %s" $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD
}

# Main script
echo -e "${YELLOW}Current version: $CURRENT_VERSION${NC}"
echo "Select version update type:"
echo "1) Major (breaking changes)"
echo "2) Minor (new features)"
echo "3) Patch (bug fixes)"
read -p "Enter choice (1-3): " choice

case $choice in
    1) update_version "major";;
    2) update_version "minor";;
    3) update_version "patch";;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1;;
esac

# Update version file
echo "$NEW_VERSION" > "$VERSION_FILE"

# Update changelog
TIMESTAMP=$(date '+%Y-%m-%d')
CHANGES=$(get_changes)

# Create changelog if it doesn't exist
if [ ! -f "$CHANGELOG_FILE" ]; then
    echo "# Changelog" > "$CHANGELOG_FILE"
    echo "" >> "$CHANGELOG_FILE"
fi

# Add new version to changelog
sed -i '' "2i\\
\\
## [$NEW_VERSION] - $TIMESTAMP\\
\\
$CHANGES\\
" "$CHANGELOG_FILE"

# Create git tag
git add "$VERSION_FILE" "$CHANGELOG_FILE"
git commit -m "docs: bump version to $NEW_VERSION"
git tag -a "v$NEW_VERSION" -m "Version $NEW_VERSION"

echo -e "${GREEN}Version updated to $NEW_VERSION${NC}"
echo -e "${GREEN}Changelog updated${NC}"
echo -e "${YELLOW}Don't forget to push changes:${NC}"
echo "git push && git push --tags" 