#!/bin/bash

# Removes articles from Atlas PDF TOC that are only for admins. This is a client request.
# Unclear note: [!include[analytics catalog](includes/analytics-catalog.md)]

cp articles/atlas/toc.yml articles/atlas/users-only/ 

# Temporarily remove Analytics Catalog section from interface-tour-atlas.md per client request
## Analytics Catalog section is a partial - remove from Atlas directory so it cannot possibly be included
mkdir articles/atlas/users-only/temp
mv articles/atlas/includes/analytics-catalog.md articles/atlas/users-only/temp

## Move interace-tour-atlas.md to temp folder for safekeeping (will restore later)
cp articles/atlas/interface-tour-atlas.md articles/atlas/users-only/temp

## Remove reference to partial from interface-tour-atlas.md so the reference text is not printed 
sed -i '/analytics-catalog.md/d' toc.yml articles/atlas/interface-tour-atlas.md

cd articles/atlas/users-only

# Script won't delete TOC entry on the final line unless something is below it
sed -i -e '$alazyshortcut' toc.yml

# Remove admin articles
sed -i 'N;/troubleshoot-atlas.md/!P;D' toc.yml
sed -i 'N;/set-permissions-for-atlas.md/!P;D' toc.yml
sed -i 'N;/hide-source-mart-bindings.md/!P;D' toc.yml
sed -i 'N;/configuring-dos-marts.md/!P;D' toc.yml
sed -i 'N;/maintain-dos-home-page.md/!P;D' toc.yml
sed -i 'N;/see-analytics-items.md/!P;D' toc.yml
sed -i 'N;/create-analytics-item.md/!P;D' toc.yml
sed -i 'N;/health-status.md/!P;D' toc.yml
sed -i 'N;/use-the-app-switcher.md/!P;D' toc.yml

# Delete lines for CSS classes
sed -i '/class:/d' toc.yml

#Delete required ending
sed -i '/lazyshortcut/d' toc.yml

# Relative references
sed -i 's/href: /href: ..\//g' toc.yml

cd ..
cd ..
