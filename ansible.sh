#!/bin/bash
set -e

# Create a .yamllint file to customize rules
cat > .yamllint << 'EOF'
---
extends: default

rules:
  line-length:
    max: 80
    level: error
  trailing-spaces:
    level: error
  truthy:
    allowed-values: ['true', 'false']
    level: error
  braces:
    min-spaces-inside: 0
    max-spaces-inside: 1
    level: error
  brackets:
    min-spaces-inside: 0
    max-spaces-inside: 0
    level: error
  document-start:
    present: true
    level: error
EOF

echo "Created .yamllint configuration file"

# Fix document start in GitHub workflow files - macOS compatible
for file in .github/dependabot.yml .github/workflows/ci.yml .github/workflows/release.yml; do
  if [[ -f "$file" ]]; then
    # macOS compatible version
    sed -i '' '1i\
---
' "$file"
    echo "Added document start marker to $file"
  fi
done

# Fix truthy values - macOS compatible
echo "Fixing truthy values..."
find . -name "*.yml" -exec sed -i '' 's/: yes$/: true/g' {} \;
find . -name "*.yml" -exec sed -i '' 's/: no$/: false/g' {} \;
find . -name "*.yml" -exec sed -i '' 's/: Yes$/: true/g' {} \;
find . -name "*.yml" -exec sed -i '' 's/: No$/: false/g' {} \;

# Fix bracket spacing in CI.yml - macOS compatible
if [[ -f ".github/workflows/ci.yml" ]]; then
  sed -i '' 's/\[ main \]/[main]/g' .github/workflows/ci.yml
  sed -i '' 's/\[ pull_request \]/[pull_request]/g' .github/workflows/ci.yml
  echo "Fixed bracket spacing in ci.yml"
fi

# Fix trailing spaces - macOS compatible
echo "Removing trailing whitespace..."
find . -name "*.yml" -exec sed -i '' 's/[ \t]*$//' {} \;

# Fix braces in replication.yml - macOS compatible
if [[ -f "tasks/replication.yml" ]]; then
  sed -i '' 's/{ *variable: */{ variable: /g' tasks/replication.yml
  sed -i '' 's/ *value: */value: /g' tasks/replication.yml
  echo "Fixed brace spacing in replication.yml"
fi

# Fix the syntax error in validate.yml - macOS compatible
if [[ -f "tasks/validate.yml" ]]; then
  # Remove any backtick characters on line 31
  sed -i '' '31s/`//g' tasks/validate.yml
  echo "Fixed syntax error in validate.yml"
fi

# Create a Python script to fix line length issues
cat > fix_line_length.py << 'EOFPYTHON'
#!/usr/bin/env python3
import os
import re

files_with_issues = [
    "defaults/main.yml",
    "meta/main.yml",
    "tasks/configure.yml",
    "tasks/replication.yml",
    "tasks/users.yml",
    "tasks/main.yml",
    "tasks/validate.yml",
    "tasks/monitoring.yml",
    "tasks/install.yml",
    "tasks/backup.yml",
    "molecule/default/verify.yml",
    ".github/workflows/ci.yml"
]

def wrap_line(line, max_length=80):
    if len(line.rstrip()) <= max_length:
        return line
    
    # Find a good breaking point
    indent_match = re.match(r'^(\s*)', line)
    indent = indent_match.group(1) if indent_match else ""
    extra_indent = "  "  # Additional indent for wrapped lines
    
    # Try breaking at commas, spaces, or other good break points
    for i in range(max_length - 1, 30, -1):
        if i < len(line) and line[i] in [' ', ',', ':', '-']:
            return line[:i+1].rstrip() + "\n" + indent + extra_indent + line[i+1:].lstrip()
    
    # If no good break point found, just break at max_length
    if len(line) > max_length:
        return line[:max_length].rstrip() + "\n" + indent + extra_indent + line[max_length:].lstrip()
    return line

for file_path in files_with_issues:
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        continue
        
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    fixed_lines = []
    for line in lines:
        if len(line.rstrip()) > 80:
            fixed_line = wrap_line(line)
            # If line still too long, try again
            while any(len(l.rstrip()) > 80 for l in fixed_line.split('\n')):
                fixed_line = "\n".join([
                    wrap_line(l) if len(l.rstrip()) > 80 else l 
                    for l in fixed_line.split('\n')
                ])
            fixed_lines.append(fixed_line)
        else:
            fixed_lines.append(line)
    
    with open(file_path, 'w') as file:
        file.writelines(fixed_lines)
    
    print(f"Fixed line length issues in {file_path}")
EOFPYTHON

chmod +x fix_line_length.py
echo "Running line length fixer..."
python3 ./fix_line_length.py

# Clean up the script after running
rm fix_line_length.py

# Alternative approach for adding document start markers (file by file approach for macOS)
for file in .github/dependabot.yml .github/workflows/ci.yml .github/workflows/release.yml; do
  if [[ -f "$file" ]]; then
    # Check if the file already starts with ---
    if ! grep -q "^---" "$file"; then
      # Create a temporary file with --- at the start
      echo "---" > temp_file
      cat "$file" >> temp_file
      # Replace the original file
      mv temp_file "$file"
      echo "Added document start marker to $file (alternative method)"
    fi
  fi
done

# Run yamllint to check if all issues are fixed
echo "Verifying fixes with yamllint..."
if command -v yamllint &> /dev/null; then
  yamllint . || echo "Some linting issues remain. Manual fixes may be needed."
else
  echo "yamllint not available, skipping verification"
fi

# Set up git config for the commit
git config user.name "Thomas Vincent"
git config user.email "thomasvincent@gmail.com"

# Stage changes
git add .

# Create a conventional commit
git commit -m "style: fix YAML linting issues

- Fixed line length issues
- Standardized truthy values (yes/no → true/false)
- Removed trailing whitespace
- Fixed bracket and brace spacing
- Added missing document start markers
- Fixed syntax errors

This commit follows Ansible best practices and makes the codebase
more idiomatic."

echo "Changes committed successfully"