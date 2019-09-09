#!/usr/bin/env bash

# Clear page folder except _config.yml and index.md
echo "Clearing page folder..." 
cd ../sevennewbookshelves.github.io
git pull origin master

for f in *
do
	echo $f
	if [ $f != '_config.yml' ] && [ $f != 'index.md' ]
	then
		rm -f $f
	fi
done

# Pull wiki
cd ../sevennewbookshelves.github.io.wiki
echo "Pulling wiki..."
git pull origin master

# Copy all files from wiki
echo "Copying files..."
git_add_command=(git add)
for fwiki in *
do
	cp $fwiki "../sevennewbookshelves.github.io/$fwiki"
	git_add_command+=("$fwiki")
done

# Add all files to git page repository
echo "Adding, commiting and pushing page repository..."
cd ../sevennewbookshelves.github.io
"${git_add_command[@]}"

todays_date=$(date +"%Y-%m-%d") 
git commit -m "Updates wiki files $todays_date"

# Push to page repository
git push origin master
