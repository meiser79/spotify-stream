FROM ubuntu

RUN useradd -u 1000 -m -d /home/doggo -s /bin/bash doggo
RUN usermod -aG audio doggo

RUN apt update
RUN apt install -y curl pulseaudio icecast2 darkice

RUN curl -L https://github.com/Spotifyd/spotifyd/releases/latest/download/spotifyd-linux-slim.tar.gz -o spotifyd-linux-slim.tar.gz
RUN tar -xvf spotifyd-linux-slim.tar.gz -C /bin/

RUN mkdir -p /home/doggo/.config/spotifyd/
COPY spotifyd.conf /home/doggo/.config/spotifyd/spotifyd.conf

COPY darkice.cfg /etc/darkice.cfg

RUN chown -R doggo /home/doggo/.config 

COPY configure.sh /bin/configure.sh
RUN chmod +x /bin/configure.sh

COPY start.sh /bin/start.sh
RUN chmod +x /bin/start.sh

COPY entry.sh /bin/entry.sh
RUN chmod +x /bin/entry.sh

COPY on_song_change.sh /bin/on_song_change.sh
RUN chmod +x /bin/on_song_change.sh

ENV SPOTIFY_DEVICE_NAME=Stream
# possible values: audiodongle, avr, computer, smartphone, speaker, stb, tablet, tv
ENV SPOTIFY_DEVICE_TYPE=avr
ENV SPOTIFY_BITRATE=320
ENV SPOTIFY_INITIAL_VOLUME=90

ENV ICECAST_USERNAME=admin
ENV ICECAST_PASSWORD=bozotheclown

EXPOSE 8000

ENTRYPOINT ["/bin/entry.sh"]