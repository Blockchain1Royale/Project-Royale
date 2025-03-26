#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
BACKUP_DIR="./backups/docs"
MAX_BACKUPS=7  # Keep a week's worth of backups

echo -e "${YELLOW}Starting documentation backup...${NC}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create timestamp for backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/docs_backup_$TIMESTAMP.tar.gz"

# Create backup
tar -czf "$BACKUP_FILE" docs/ .gitbook.yaml

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Backup created successfully: $BACKUP_FILE${NC}"
else
    echo -e "${RED}Backup failed!${NC}"
    exit 1
fi

# Remove old backups if we have more than MAX_BACKUPS
backup_count=$(ls -1 "$BACKUP_DIR"/docs_backup_*.tar.gz 2>/dev/null | wc -l)
if [ "$backup_count" -gt "$MAX_BACKUPS" ]; then
    echo -e "${YELLOW}Removing old backups...${NC}"
    ls -1t "$BACKUP_DIR"/docs_backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs rm
fi

echo -e "${GREEN}Backup process completed${NC}"

# Optional: Upload backup to remote storage (uncomment and configure as needed)
# if [ -n "$REMOTE_BACKUP_URL" ]; then
#     echo -e "${YELLOW}Uploading backup to remote storage...${NC}"
#     curl -X PUT -T "$BACKUP_FILE" "$REMOTE_BACKUP_URL"
# fi 