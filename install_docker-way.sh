#!/bin/bash
curl https://minecraft.gamepedia.com/Version_history | sed -nr 's/^.*([1-9]+\.[0-9]+\.[0-9]+)" title="[1-9]+\.[1-9]+\.[1-9]+.*$/\1/p' > minecraft.txt
while read ligne
do
#version=$(curl https://minecraft.gamepedia.com/Version_history | sed -nr 's/^.*([1-9]+\.[0-9]+\.[0-9]+)" title="[1-9]+\.[1-9]+\.[1-9]+.*$/\1/p' | head -n1)
version=$ligne
sed -ri 's/^(.*versionminecraft:).*$/\1 '$version'/' docker-compose.yml
#Now let's build the container
docker-compose up --force-recreate -d 
if [[ $? = 0 ]] 
then
	echo "Server is running."
else
	echo "La mise en service du conteneur a rencontré un problème."
	exit 1
fi
docker tag serveurminecraft:latest jimmyord/minecraft_server:$version
#docker tag serveurminecraft:latest jimmyord/minecraft_server:last
docker login -u $dockerlogin -p $dockerpassword
docker push jimmyord/minecraft_server:$version
#docker push jimmyord/minecraft_server:last
done < <(cat minecraft.txt)
