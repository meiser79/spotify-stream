#!/bin/sh
separator="---------------------"

echo "🔊 starting pulseaudio"
su-exec user /usr/bin/pulseaudio -D
sleep 5

echo
echo "$separator"
echo

echo "📻 starting icecast"
icecast -c /etc/icecast.xml -b

echo
echo "$separator"
echo

echo "🧊 starting darkice"
su-exec user sh -c "/usr/bin/darkice -c /etc/darkice/darkice.cfg &"
sleep 5

echo
echo "$separator"
echo

echo "🔨 updating icecast's metadata"
wget -q -O - --user "$ICECAST_USERNAME" --password "$ICECAST_PASSWORD" http://localhost:8000/admin/metadata?mount=/$DARKICE_MOUNT_POINT\&mode=updinfo\&song="${DARKICE_NAME//\\/}"

echo
echo "$separator"
echo

echo "🎵 starting librespot"
su-exec user librespot \
    --name "$LIBRESPOT_DEVICE_NAME" \
    --device-type "$LIBRESPOT_DEVICE_TYPE" \
    --backend pulseaudio \
    --bitrate 320 \
    --cache "$LIBRESPOT_CACHE" \
    --disable-audio-cache \
    --enable-volume-normalisation \
    --initial-volume "$LIBRESPOT_INITIAL_VOLUME" \
    --zeroconf-interface "$LIBRESPOT_ZEROCONF_IP" \
    --zeroconf-port "$LIBRESPOT_ZEROCONF_PORT" \
    --autoplay off
