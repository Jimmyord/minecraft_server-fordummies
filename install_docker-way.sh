#!/bin/bash

#Starting the docker service if it is inactive
if [[ $(systemctl is-active docker) = "active" ]]
then
	echo "Docker is running. Great!"

elif [[ $(systemctl is-active docker) = "inactive" ]]
then
	echo "Docker is inactive. I'm starting it for you"
	systemctl start docker
else
	echo "Docker service not found. You should install docker"
	exit 1
fi

#Now let's build the container
docker-compose up -d 
if [[ $? = 0 ]] 
then echo "Le serveur est lancé."
else echo "La mise en service du conteneur a rencontré un problème."
fi

exit 0
