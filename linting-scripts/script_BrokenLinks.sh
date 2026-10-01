# https://github.com/tcort/markdown-link-check
# Prerequisite: npm install -g markdown-link-check
# Broken links indicated in output file by `✖` and `⚠` (special characters) - search Regex for `\[[^✓]\]`
# Checks public URLs (errors thrown on URLs private to Catalyst) and links between Markdown files; does not check @docfx-link.md

cd ..
find \( -name 'node_modules' -o -name 'specs' -o -name 'templates' -o -name 'vale-styles' -o -name 'link-status.md' \) -prune -o -name \*.md -exec markdown-link-check {} \; > link-status.md
