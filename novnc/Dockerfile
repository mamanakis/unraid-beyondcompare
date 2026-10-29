FROM jlesage/baseimage-gui:ubuntu-24.04-v4

ENV APP_NAME="Beyond Compare 5"

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg2 ca-certificates && \
    wget -qO /etc/apt/trusted.gpg.d/scootersoftware.asc https://www.scootersoftware.com/DEB-GPG-KEY-scootersoftware.asc && \
    wget -qO /etc/apt/sources.list.d/scootersoftware.list https://www.scootersoftware.com/scootersoftware.list && \
    apt-get update && \
    mv /var/log /var/log.bak && mkdir /var/log && \
    apt-get install --no-install-recommends -y bcompare && \
    rm -rf /var/log && mv /var/log.bak /var/log && \
    wget -U "Mozilla/5.0" -qO /tmp/icon.png "https://www.scootersoftware.com/images/media_BeyondCompareIcon512x512.png" && \
    install_app_icon.sh /tmp/icon.png && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/icon.png

RUN echo "#!/bin/sh" > /startapp.sh && \
    echo "exec /usr/bin/bcompare" >> /startapp.sh && \
    chmod +x /startapp.sh
