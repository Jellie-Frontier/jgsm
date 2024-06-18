FROM ubuntu:latest

LABEL maintainer="thekraken8him"

ENV TIMEZONE=America/Los_Angeles \
    PUID=1000 \
    PGID=1000 

EXPOSE 19132-19133/udp

RUN apt-get update
RUN apt-get install software-properties-common apt-transport-https ca-certificates curl unzip docker -y
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && \
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

COPY runtime.sh runtime.sh

RUN chmod 770 runtime.sh 

CMD ["/bin/bash", "runtime.sh"]