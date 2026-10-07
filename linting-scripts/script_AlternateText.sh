#!/bin/bash

# This script adds alternate text to Markdown image references derived from the filename to prevent markdownlint errors.

cd ..
cd articles

# These pages have image refs embedded in HTML, which breaks the script
#Atlas
page1='maintain-dap-home-page.md'
page2='visualizations.md'
page3='final-steps.md'
#IDEA
page4='manage-favorite-applications.md'
page5='edit-application.md'
page6='export-application.md'

for file in $(find . -type f -name "*.md" ! -name "$page1" ! -name "$page2" ! -name "$page3" ! -name "$page4" ! -name "$page5" ! -name "$page6"); do

# `-n "$line"`` deals with problem that `while read` won't process an image ref on the final line of Markdown file if no blank line is following it
while read line || [ -n "$line" ]; do
if [[ $line =~ "![]" ]]; then

# Print line without alternate text
echo $line > 1.txt

# Get filename (aka the string after last instance of / in filepath)
echo | grep -oE "[^\/]+$" < 1.txt > 2.txt

# Remove dashes in filename
sed -i 's|-| |g' 2.txt

# Remove file ending
sed -i -E 's/\.png|\.jpg|\)//g' 2.txt

imageFilename=$(cat 2.txt)

alternateText=`echo $line | sed -E "s/(\S+\[)(\].\S+.)/\1$imageFilename\2/"`

# Line without alternate text - remove special characters
plainLine=${line}
plainLine1=$(sed -e 's/\[/\\[/g' <<<"$plainLine")
plainLine2=$(sed -e 's/\]/\\]/g' <<<"$plainLine1")
plainLine3=$(sed -e 's|\/|\\/|g' <<<"$plainLine2")
plainLine4=$(cut -c2- <<<"$plainLine3")
plainLine5=$(awk '$0="\\!"$0' <<<"$plainLine4")

echo $plainLine5

# Line with alternate text - remove special characters
finishedLine=${alternateText}
finishedLine1=$(sed -e 's/\[/\\[/g' <<<"$finishedLine")
finishedLine2=$(sed -e 's/\]/\\]/g' <<<"$finishedLine1")
finishedLine3=$(sed -e 's|\/|\\/|g' <<<"$finishedLine2")
finishedLine4=$(cut -c2- <<<"$finishedLine3")
finishedLine5=$(awk '$0="\\!"$0' <<<"$finishedLine4")

echo $finishedLine5

# Replace original line with line that has alternate text
sed -i "s|$plainLine5|$finishedLine5|" $file

fi
done < $file
done

rm -f -- 1.txt
rm -f -- 2.txt