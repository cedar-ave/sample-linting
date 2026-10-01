# In every Markdown file, find where the YAML title and H1 are different
# Run `./script_MatchYAMLTitleAndH1.sh > ../articles/output.txt` to output results in Docs/articles/output.txt

cd ..
cd articles

for file in $(find . -type f -name "*.md"); do

filename=${file%.*}

#  Retain only H1 line because there are # in code block comments
sed -E '/^# .*?$/q' $file > $filename.txt

# Get file's yaml title for compare
sed '3q;d' $filename.txt > $filename-yaml.txt
sed -i 's/title: //g' $filename-yaml.txt

# Get file's H1 for compare
grep -Eow "^# .*$" $filename.txt > $filename-heading.txt
sed -i 's/# //g' $filename-heading.txt
sed -i 's/ (demo mode only)//g' $filename-heading.txt

# Compare
file1=$filename-yaml.txt
file2=$filename-heading.txt

cover='documentType: cover'
if cmp -s "$file1" "$file2"; then
#    printf 'The file "%s" is the same as "%s"\n' "$file1" "$file2"
    :
else

# Exclude results that indicate headings are the same
# Exclude cover files, partials dirs, includes dirs, and others
if
[[ ! ( "$file1" =~ "cover" ||
"$file1" =~ "/partials/" ||
"$file1" =~ "cover-" ||
"$file1" =~ "/partials/" ||
"$file1" =~ "/shared/" ||
"$file1" =~ "/includes/" ||
"$file1" =~ "/dos/dos-" ||
"$file1" =~ "/machine-learning/" ||
"$file1" =~ "/real-time/" ||
"$file1" =~ "touchstone" ||
"$file1" =~ "supported-browsers" ||
"$file1" =~ "DPSv.*-Ping*" ||
"$file1" =~ "about") ]]

then 
printf 'The file "%s" is different from "%s"\n' "$file1" "$file2"
echo "$(cat $file1)"
echo "$(cat $file2)"
echo ""
fi
fi
done

# Remove *.txt files
find . -name "*.txt" ! -name "output.txt" -type f -delete
