#!/bin/bash
separator="\n---------------------\n"

echo "🔊 starting pulseaudio"
su - ubuntu -c "pulseaudio -D"
sleep 2

echo -e $separator

echo "📻 starting icecast"
service icecast2 start

echo -e $separator

echo "🧊 starting darkice"
su - ubuntu -c "darkice -c /etc/darkice.cfg & sleep 2 && disown"

echo -e $separator

echo "🔨 updating icecast's metadata"
wget -q -O - --user $ICECAST_USERNAME --password $ICECAST_PASSWORD http://localhost:8000/admin/metadata?mount=/$DARKICE_MOUNT_POINT\&mode=updinfo\&song="${DARKICE_NAME/\\/}"

echo -e $separator

echo "🎵 starting librespot"
su - ubuntu -c "librespot --name $LIBRESPOT_DEVICE_NAME --device-type $LIBRESPOT_DEVICE_TYPE --backend pulseaudio --bitrate 320 --cache $LIBRESPOT_CACHE --disable-audio-cache --enable-volume-normalisation --initial-volume $LIBRESPOT_INITIAL_VOLUME --zeroconf-port $LIBRESPOT_ZEROCONF_PORT --autoplay off"
