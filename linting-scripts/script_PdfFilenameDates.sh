#!/bin/sh
# This script prepends the DOS version to the filename and appends today's date.
# Run after generating PDFs via `docfx pdf`.
version="DOS21.1"
cd ..
for path in _site_pdf/Docs_articles _site_pdf/Docs_articles api-reference ; do
cd $path
for f in *.pdf; do 
mv "$f" ""$version"_${f%.pdf}_$(date +"%d%b%Y").pdf"; 
done
cd ..
cd ..
done