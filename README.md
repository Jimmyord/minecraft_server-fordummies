# Minecraft server for dummies

(Very) Easily install a minecraft server inside a Docker container

# Requirement (Docker part): 
 - Docker Engine 17.09+
 - Docker-compose 1.18.0+ (PATH include)
 
# CircleCI implications :
All versions of the game server are compiled (each month!) and available on Docker Hub.


# How to build it up :
- Clone the repo (No, really?)
- Store your save folder in "files/your-save-folder-inside-me/" (If you got one)
- Check which minecraft version you want to play at [the Minecraft Wiki](https://minecraft.gamepedia.com/Version_history)
- Run install_docker-way.sh as root
- Follow the instructions
- Play!

# I don't give a fuck about building, i'm trusting :
-docker pull jimmyord/minecraft_server:VERSION
-docker run -d --name minecraft -p 25565:25565 serveurminecraft:VERSION
