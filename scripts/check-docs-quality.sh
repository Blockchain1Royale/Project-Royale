#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Checking documentation quality...${NC}"

# Configuration
MIN_WORDS_PER_SECTION=50
MAX_LINE_LENGTH=120
DOCS_DIR="./docs"
QUALITY_REPORT="./docs/reports/quality_report.md"

# Create reports directory
mkdir -p "./docs/reports"

# Initialize quality report
cat > "$QUALITY_REPORT" << EOL
# Documentation Quality Report
Generated on $(date '+%Y-%m-%d %H:%M:%S')

## Quality Metrics
EOL

# Initialize counters
total_issues=0
total_warnings=0

# Function to check section length
check_section_length() {
    local file=$1
    local section_start=0
    local word_count=0
    local current_section=""
    
    while IFS= read -r line; do
        if [[ $line =~ ^#+ ]]; then
            if [ $section_start -eq 1 ]; then
                if [ $word_count -lt $MIN_WORDS_PER_SECTION ]; then
                    echo -e "${YELLOW}Warning: Section '$current_section' in $file has only $word_count words${NC}"
                    total_warnings=$((total_warnings + 1))
                    echo "- Warning: Section '$current_section' is too short ($word_count words)" >> "$QUALITY_REPORT"
                fi
            fi
            current_section=$line
            word_count=0
            section_start=1
        else
            word_count=$((word_count + $(echo "$line" | wc -w)))
        fi
    done < "$file"
}

# Function to check line length
check_line_length() {
    local file=$1
    while IFS= read -r line; do
        length=${#line}
        if [ $length -gt $MAX_LINE_LENGTH ]; then
            echo -e "${YELLOW}Warning: Line too long in $file: $length characters${NC}"
            total_warnings=$((total_warnings + 1))
            echo "- Warning: Line exceeds $MAX_LINE_LENGTH characters in $file" >> "$QUALITY_REPORT"
        fi
    done < "$file"
}

# Check all markdown files
find "$DOCS_DIR" -type f -name "*.md" | while read -r file; do
    echo -e "${BLUE}Checking $(basename "$file")...${NC}"
    
    # Check for empty files
    if [ ! -s "$file" ]; then
        echo -e "${RED}Error: Empty file $file${NC}"
        total_issues=$((total_issues + 1))
        echo "- Error: Empty file $file" >> "$QUALITY_REPORT"
        continue
    fi
    
    # Check section length
    check_section_length "$file"
    
    # Check line length
    check_line_length "$file"
    
    # Check for missing front matter
    if ! grep -q "^---$" "$file"; then
        echo -e "${YELLOW}Warning: Missing front matter in $file${NC}"
        total_warnings=$((total_warnings + 1))
        echo "- Warning: Missing front matter in $file" >> "$QUALITY_REPORT"
    fi
done

# Add summary to report
cat >> "$QUALITY_REPORT" << EOL

## Summary
- Total Issues: $total_issues
- Total Warnings: $total_warnings

*Report generated by documentation quality checker*
EOL

echo -e "${GREEN}Quality check completed${NC}"
echo -e "Found ${RED}$total_issues issues${NC} and ${YELLOW}$total_warnings warnings${NC}"
echo -e "Full report available at: $QUALITY_REPORT"

# Exit with error if issues found
[ $total_issues -gt 0 ] && exit 1 || exit 0 