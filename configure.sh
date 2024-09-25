#!/bin/bash

echo "🔑 updating icecast credentials"

# update username
sed -i -r "s/(<admin-user>).*(<\\/admin-user>)/\1$ICECAST_USERNAME\2/ig" /etc/icecast2/icecast.xml

# update passwords
for tag in source-password relay-password admin-password password
do
  sed -i -r "s/(<$tag>).*(<\\/$tag>)/\1$ICECAST_PASSWORD\2/ig" /etc/icecast2/icecast.xml
done

echo "🔑 updating darkice credentials"
sed -i -r "s/^password.*$/password = $ICECAST_PASSWORD/" /etc/darkice.cfg 

echo "🔨 updating darkice config"
sed -i -r "s/^mountPoint.*$/mountPoint = $DARKICE_MOUNT_POINT/" /etc/darkice.cfg
sed -i -r "s/^name.*$/name = $DARKICE_NAME/" /etc/darkice.cfg
sed -i -r "s/^description.*$/description = $DARKICE_DESCRIPTION/" /etc/darkice.cfg

echo "🔨 updating spotifyd config"
sed -i -r "s/^device_name.*$/device_name = \"$SPOTIFY_DEVICE_NAME\"/" /etc/spotifyd.conf
sed -i -r "s/^device_type.*$/device_type = \"$SPOTIFY_DEVICE_TYPE\"/" /etc/spotifyd.conf
sed -i -r "s/^initial_volume.*$/initial_volume = \"$SPOTIFY_INITIAL_VOLUME\"/" /etc/spotifyd.conf
sed -i -r "s/^zeroconf_port.*$/zeroconf_port = $SPOTIFY_ZEROCONF_PORT/" /etc/spotifyd.conf

echo "🌊 configuration done"
echo -e "\n---------------------\n"
