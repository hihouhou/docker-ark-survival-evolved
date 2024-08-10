# ARK : Survival Evolved  server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV ARK_SE_VERSION 0.0.0

# Update & install packages for grafana
RUN apt-get update && \
    apt-get install -y curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0

RUN useradd -ms /bin/bash ark

USER ark

RUN mkdir -p /home/ark/steam/ark && \
    usermod -u 1000 ark

#Get steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -O /tmp/steamcmd_linux.tar.gz && \
    cd /tmp && \
    tar xf steamcmd_linux.tar.gz && \
    chmod +x steamcmd.sh && \
    ./steamcmd.sh +login anonymous +force_install_dir /home/ark/steam/ark +app_update 376030 validate +exit

WORKDIR /home/ark/steam/ark/ShooterGame/Binaries/Linux

CMD ./ShooterGameServer ${ARK_MAP}?listen?SessionName=${ARK_SESSIONNAME}?ServerPassword=${ARK_SESSION_PASSWORD}?ServerAdminPassword=${ARK_ADMIN_PASSWORD}?Port=${ARK_PORT}?QueryPort=${ARK_QUERY_PORT}?serverPVE=true -log -crossplay -servergamelog -gameplaylogging
