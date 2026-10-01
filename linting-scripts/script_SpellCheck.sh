# https://www.npmjs.com/package/spellchecker-cli
# (When necessary) Run `spellchecker --files ...etc... --generate-dictionary` to export list of all misspelled words/acronyms/codenames; then copy words to ignore to spelling.txt
# Add words to ignore to spelling.txt (`--dictionaries spelling.txt`)

cd ..
spellchecker --files 'articles/**/*.md' 'articles/**/**/*.md' 'restapi/*.md' 'tabs/**/*.md' 'index.md' --quiet --dictionaries spelling.txt