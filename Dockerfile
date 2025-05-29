FROM kasmweb/core-ubuntu-jammy:1.14.0
LABEL maintainer="DevelopmentCats"
LABEL org.opencontainers.image.title="PokeMMO for Kasm Workspaces"
LABEL org.opencontainers.image.description="PokeMMO client running in Kasm Workspaces"
LABEL org.opencontainers.image.source="https://github.com/DevelopmentCats/PokeMMO-docker"

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
ENV TITLE=PokeMMO-Docker
ENV REVISION=28887
ENV XDG_SESSION_TYPE=x11

# add local files
COPY /root /

WORKDIR $INST_SCRIPTS

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    default-jre \
    openjdk-17-jre \
    && rm -rf /var/lib/apt/lists/*

# Install PokeMMO
RUN mkdir -p /pokemmo && \
    wget https://pokemmo.com/download_file/1/ -O /pokemmo/PokeMMO-Client.zip && \
    wget https://pokemmo.com/build/images/opengraph.ce52eb8f.png -O /pokemmo/PokeMMO.png && \
    cd /pokemmo && unzip PokeMMO-Client.zip && \
    rm -f /pokemmo/PokeMMO-Client.zip && \
    chmod -R u=rwX,g=rX,o=rX /pokemmo && \
    chmod 755 /defaults/autostart && \
    chown -R 1000:1000 /pokemmo

# Create desktop shortcut
RUN mkdir -p $HOME/Desktop && \
    echo "[Desktop Entry]\nName=PokeMMO\nExec=java -jar /pokemmo/PokeMMO.jar\nIcon=/pokemmo/PokeMMO.png\nType=Application\nCategories=Game;" > $HOME/Desktop/pokemmo.desktop && \
    chmod +x $HOME/Desktop/pokemmo.desktop

# Switch back to non-root user
USER 1000

WORKDIR $HOME
VOLUME /pokemmo/config
