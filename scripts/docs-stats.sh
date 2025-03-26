#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Generating documentation statistics...${NC}"

# Directory containing documentation
DOCS_DIR="./docs"
REPORT_FILE="./docs/reports/documentation_stats.md"

# Create reports directory if it doesn't exist
mkdir -p "./docs/reports"

# Initialize report
cat > "$REPORT_FILE" << EOL
# Documentation Statistics Report
Generated on $(date '+%Y-%m-%d %H:%M:%S')

## Overview
EOL

# Count total files and directories
total_files=$(find "$DOCS_DIR" -type f -name "*.md" | wc -l)
total_dirs=$(find "$DOCS_DIR" -type d | wc -l)

echo -e "Found ${GREEN}$total_files${NC} markdown files in ${GREEN}$total_dirs${NC} directories"

# Add counts to report
cat >> "$REPORT_FILE" << EOL
- Total Markdown Files: $total_files
- Total Directories: $total_dirs

## File Statistics
EOL

# Generate per-file statistics
echo -e "${YELLOW}Analyzing individual files...${NC}"

echo "| File | Word Count | Headers | Links | Images |" >> "$REPORT_FILE"
echo "|------|------------|---------|--------|---------|" >> "$REPORT_FILE"

find "$DOCS_DIR" -type f -name "*.md" | while read -r file; do
    rel_path=${file#"$DOCS_DIR/"}
    words=$(wc -w < "$file")
    headers=$(grep -c "^#" "$file")
    links=$(grep -c "\[.*\](.*)" "$file")
    images=$(grep -c "!\[.*\](.*)" "$file")
    
    echo "| $rel_path | $words | $headers | $links | $images |" >> "$REPORT_FILE"
done

# Add timestamp to report
echo -e "\n*Last updated: $(date '+%Y-%m-%d %H:%M:%S')*" >> "$REPORT_FILE"

echo -e "${GREEN}Statistics report generated: $REPORT_FILE${NC}"

# Optional: Generate graphs using terminal-based plotting
if command -v gnuplot &> /dev/null; then
    echo -e "${YELLOW}Generating visualization...${NC}"
    # Add gnuplot commands here if needed
fi 