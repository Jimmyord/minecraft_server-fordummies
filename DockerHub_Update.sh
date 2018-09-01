#!/bin/bash
docker login -u $dockerlogin -p $dockerpassword
curl https://minecraft.gamepedia.com/Java_Edition_version_history | sed -nE 's/^.*\/([0-9]{1,2}\.[0-9]{1,2}\.?[0-9]?)" title="([0-9]{1,2}\.[0-9]{1,2}\.?[0-9]?)".*$/\1/p' > minecraft.txt
#Delete unavailable versions
sed -ir '/^.*1.2.[1-4].*$/d' minecraft.txt
while read ligne
do
	test=$(echo $ligne | sed -r 's/\./\\./g')
	test2=$(curl https://hub.docker.com/r/jimmyord/minecraft_server/tags/ | sed -En "s/^.*($test).*$/\1/p")
	if [ -n "$test2" ]
	then
		echo "$ligne existe déjà!"
	else
		version=$ligne
		sed -ri 's/^(.*versionminecraft:).*$/\1 '$version'/' docker-compose.yml
		#Building and running the container
		docker-compose up -d 
		if [[ $? = 0 ]] 
		then
			echo "Server is running."
			docker-compose down
		else
			echo "La mise en service du conteneur a rencontré un problème."
			exit 1
		fi
		docker tag serveurminecraft:latest jimmyord/minecraft_server:$version
		docker rmi serveurminecraft:latest
		docker push jimmyord/minecraft_server:$version
	#docker push jimmyord/minecraft_server:latest
	fi
done < <(cat minecraft.txt)
docker logout

