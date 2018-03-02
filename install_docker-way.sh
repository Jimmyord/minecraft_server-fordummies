#!/bin/bash
version=$(curl https://minecraft.gamepedia.com/Version_history | sed -nr 's/^.*([1-9]+\.[0-9]+\.[0-9]+)" title="[1-9]+\.[1-9]+\.[1-9]+.*$/\1/p' | head -n1)
echo $version
sed -ri 's/^(.*versionminecraft:).*$/\1 '$version'/' docker-compose.yml
cat docker-compose.yml
#Now let's build the container
docker-compose up -d 
if [[ $? = 0 ]] 
then
	echo "Server is running."
else
	echo "La mise en service du conteneur a rencontré un problème."
	exit 1
fi
docker push jimmyord/minecraft_server:$version
