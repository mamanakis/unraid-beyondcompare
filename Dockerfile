FROM lscr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ENV TITLE="Beyond Compare"

RUN apt-get update && \
    apt-get install -y wget gnupg2 && \
    wget -qO /etc/apt/trusted.gpg.d/scootersoftware.asc https://www.scootersoftware.com/DEB-GPG-KEY-scootersoftware.asc && \
    wget -qO /etc/apt/sources.list.d/scootersoftware.list https://www.scootersoftware.com/scootersoftware.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y bcompare && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "#!/bin/bash" > /defaults/autostart && \
    echo "bcompare" >> /defaults/autostart && \
    chmod +x /defaults/autostart
