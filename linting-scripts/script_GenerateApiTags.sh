#!/bin/bash

# DocFx publishes Swagger files. By default, DocFx publishes each file as one long page. A DocFx plugin splits the file by tag into multiple pages. This makes it much easier for the user to consume. A `tag` object at the end of the Swagger file is required. Some Swagger files provided by teams do not have it. This script scrapes tags from the Swagger file and makes that object.

# Run this script when a new Swagger file is added or an existing file is replaced. No need to run it every build.

# Prerequisite: jq (https://stedolan.github.io/jq)

cd ../restapi

for file in *.json; do

# JQ won't write in place
cp $file copy.json

# Collect tags from each object (not all objects have tags) and compile into a tags object
jq '.paths[][] | ({name: .tags[]}?)' $file > tags.json

# Remove duplicate tags; merge the tags object with the Swagger file (located at EOF) -- some files already have a tags object, some don't
jq -s 'unique | {tags: .}' tags.json > object.json

#jq -s '.[0] * .[1]' tmp.json file1.json > $file
jq -s add copy.json object.json > $file

rm copy.json
rm tags.json
rm object.json
done