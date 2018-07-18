#!/bin/bash
#Available versions
curl https://minecraft.gamepedia.com/Java_Edition_version_history | sed -nr 's/^.*([1-9]+\.[0-9]+\.[0-9]+)" title="[1-9]+\.[1-9]+\.[1-9]+.*$/\1/p' > minecraft.txt
sed -ir '/^.*1.2.[1-4].*$/d' minecraft.txt 1>&2>/dev/null
echo 'Available Versions : '
cat minecraft.txt
read -p "Give me the version you want : " version
#Building the container
sed -ri 's/^(.*versionminecraft:).*$/\1 '$version'/' docker-compose.yml
docker-compose up -d 
if [[ $? = 0 ]] 
then
	echo "Server is running."
	docker-compose down
else
	echo "La mise en service du conteneur a rencontré un problème."
	exit 1
fi
