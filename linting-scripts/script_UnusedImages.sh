#!/bin/bash

# Delete the CAP/Docs/PlatformDocs/wwwroot directory. Build site locally (in CAP/Docs, run `npm start`). Then run the script at the root of CAP/Docs/PlatformDocs/wwwroot. To bulk delete: In the output log (CAP/Docs/PlatformDocs/wwwroot/find-unused_images.log), search/replace the first part of filepath with `git rm` and paste the entire list in the terminal at the root of CAP/Docs.

# https://gist.github.com/sugarmo/8470598

cd ..

# Escape code
esc=`echo -en "\033"`

# Set colors
cc_red="${esc}[0;31m"
cc_green="${esc}[0;32m"
cc_yellow="${esc}[0;33m"
cc_blue="${esc}[0;34m"
cc_normal=`echo -en "${esc}[m\017"`

echo "Creating files index..."
files=(`find . -type f  \( ! -path './backup/*' ! -path './node_modules/*' ! -path './External/*' -and \( -name '*.xib' -or -name '*.[mh]' -or -name '*.storyboard' -or -name '*.mm' -or -name '*.html' -or -name '*.css' -or -name '*.js' -or -name '*.plist' \) \) -exec echo ''{}'' \;`)

echo "Creating images index..."
images=(`find . -type f \( ! -path './backup/*' ! -path './node_modules/*' ! -path './External/*' -and \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' \) \) -exec echo ''{}'' \;`)
image_count=${#images[@]}

i=0
unused_count=0

echo 'Unused file list:' > ./find-unused_images.log

for image in ${images[*]} 
do
	let "i += 1"

	name=`basename -s .png $image`
	name=`basename -s .jpg $name`
	name=`basename -s .jpeg $name`
	name=`basename -s @2x $name`

	if ! grep -qhs "\b$name\b" ${files[*]}; then
		let "unused_count += 1"
		echo "($i / $image_count) $image ${cc_red}not referenced${cc_normal}"
		echo $image >> ./find-unused_images.log
	else
		echo "($i / $image_count) $image ${cc_green}checked${cc_normal}."
	fi

done

echo "$unused_count unused images found. See find-unused_images.log for found list."
echo ''
