FROM jlesage/baseimage-gui:ubuntu-24.04-v4

# Set the application name displayed in the browser tab and internal menu
ENV APP_NAME="Beyond Compare 5"

# Install dependencies, configure the APT repo, install bcompare, set the icon, and clean up
RUN apt-get update && \
    apt-get install -y wget gnupg2 gvfs-backends && \
    wget -qO /etc/apt/trusted.gpg.d/scootersoftware.asc https://www.scootersoftware.com/DEB-GPG-KEY-scootersoftware.asc && \
    wget -qO /etc/apt/sources.list.d/scootersoftware.list https://www.scootersoftware.com/scootersoftware.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y bcompare && \
    APP_ICON_URL="https://www.scootersoftware.com/images/media_BeyondCompareIcon512x512.png" && \
    install_app_icon.sh "$APP_ICON_URL" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure the jlesage initialization script to launch the Beyond Compare binary
RUN echo "#!/bin/sh" > /startapp.sh && \
    echo "exec /usr/bin/bcompare" >> /startapp.sh && \
    chmod +x /startapp.sh
