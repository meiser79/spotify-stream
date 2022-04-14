#!/bin/bash
separator="\n---------------------\n"

echo "🔊 starting pulseaudio"
su - doggo -c "pulseaudio -D"
sleep 2

echo -e $separator

echo "📻 starting icecast"
service icecast2 start

echo -e $separator

echo "🧊 starting darkice"
su - doggo -c "darkice -c /etc/darkice.cfg & sleep 2 && disown"

echo -e $separator

echo "🎵 starting spotifyd"
su - doggo -c "spotifyd --no-daemon --device-name $SPOTIFY_DEVICE_NAME --device-type $SPOTIFY_DEVICE_TYPE --initial-volume $SPOTIFY_INITIAL_VOLUME --username $SPOTIFY_USERNAME --password $SPOTIFY_PASSWORD"