FROM lscr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ENV TITLE="Beyond Compare"

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://www.scootersoftware.com/files/bcompare-5.2.2.32209_amd64.deb -O /tmp/bcompare.deb && \
    apt-get install --no-install-recommends -y /tmp/bcompare.deb && \
    rm /tmp/bcompare.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "#!/bin/bash" > /defaults/autostart && \
    echo "bcompare" >> /defaults/autostart && \
    chmod +x /defaults/autostart
