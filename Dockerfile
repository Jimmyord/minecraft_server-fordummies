# NAME             : minecraft
# TO_BUILD         : docker build --build-arg version=[VERSION DU SERVEUR] -t serveurminecraft:latest .
# TO_RUN           : docker run -d --name minecraft -p 25565:25565 -v saveminecraft:/opt/minecraft/ serveurminecraft:latest
FROM openjdk:8-jre
ARG versionminecraft
#Install rsync and cron
RUN apt-get update
#Creation of the folder where the server will run
RUN mkdir /opt/minecraft
WORKDIR /opt/minecraft
#Donwnload Minecraft Server
RUN wget $(curl https://minecraft.gamepedia.com/Java_Edition_$versionminecraft | sed -rn 's/.*href="(.*\.jar)">Server<\/a>.*/\1/p')
#Copy files / Copy your save in "files/your-save-folder-inside-me" if u want to use it!!!
ADD files/eula.txt .
ADD files/server.properties .
ADD files/ops.json .
ADD files/your-save-folder-inside-me ./save/
#Start minecraft
#VOLUME /opt/minecraft/
ENTRYPOINT ["java", "-Xms1536M", "-Xmx1536M", "-jar", "/opt/minecraft/server.jar", "nogui"]
EXPOSE 25565
#Add your save to the server
#Use the script : save.sh
