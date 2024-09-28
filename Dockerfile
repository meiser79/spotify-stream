FROM ubuntu:latest

RUN usermod -aG audio ubuntu

RUN apt update && apt upgrade -y \
 && apt install -y \
    darkice \
    icecast2 \
    iproute2 \
    pulseaudio \
    wget \
 && apt clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache /root/.cache

COPY darkice.cfg /etc/darkice.cfg

COPY librespot.conf /etc/librespot.conf

COPY librespot /usr/local/bin/librespot
RUN chmod +x /usr/local/bin/librespot

COPY configure.sh /usr/local/bin/configure.sh
RUN chmod +x /usr/local/bin/configure.sh

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

COPY entry.sh /usr/local/bin/entry.sh
RUN chmod +x /usr/local/bin/entry.sh

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/entry.sh"]
