FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base

MAINTAINER inxs212

RUN \
	apt update \
	&& apt install -y jq curl wget unzip nano

# get latest LMP release

WORKDIR /LMP-server
RUN curl --silent "https://api.github.com/repos/LunaMultiplayer/LunaMultiplayer/releases/latest" | jq -r '.assets[3].browser_download_url' | wget -i -
RUN unzip LunaMultiplayer-Server-Release.zip

# remove not needed files
RUN rm -rf ./LMPClient && rm ./LunaMultiplayer-Server-Release.zip
WORKDIR /LMP-server/LMPServer
RUN mkdir logs


EXPOSE 8800/udp
EXPOSE 8801/udp
EXPOSE 8900/tcp

VOLUME /LMP-server/LMPServer

CMD dotnet Server.dll
