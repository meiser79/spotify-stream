FROM alpine:latest

RUN apk add --no-cache \
    alsa-plugins-pulse \
    bash \
    darkice \
    icecast \
    mailcap \
    pulseaudio \
    su-exec \
    tini \
    wget

RUN adduser -D -G audio -u 1000 user

COPY darkice.cfg /etc/darkice/darkice.cfg
COPY librespot configure.sh entry.sh start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*

EXPOSE 8000

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entry.sh"]
