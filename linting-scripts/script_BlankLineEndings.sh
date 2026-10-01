#!/bin/sh

# Adds a blank line at end of Markdown file if one doesn't exist to avoid a markdownlint error

cd ..
cd articles

for file in $(find . -type f -name "*.md"); do
if [ "$(tail -c1 "$file"; echo x)" != $'\nx' ]; then
    echo "" >>"$file"
fi
done