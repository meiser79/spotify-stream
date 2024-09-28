#!/bin/bash

echo "🔑 updating icecast config"

sed -i -r "s/(<admin>).*(<\\/admin>)/\1$ICECAST_ADMIN\2/ig" /etc/icecast2/icecast.xml
sed -i -r "s/(<hostname>).*(<\\/hostname>)/\1$ICECAST_HOSTNAME\2/ig" /etc/icecast2/icecast.xml
sed -i -r "s/(<location>).*(<\\/location>)/\1$ICECAST_LOCATION\2/ig" /etc/icecast2/icecast.xml
sed -i -r "s/(<burst-on-connect>).*(<\\/burst-on-connect>)/\10\2/ig" /etc/icecast2/icecast.xml

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

#echo "🔨 updating librespot config"
#sed -i -r "s/^LIBRESPOT_DEVICE_NAME.*$/LIBRESPOT_DEVICE_NAME=\"$LIBRESPOT_DEVICE_NAME\"/" /etc/librespot.conf
#sed -i -r "s/^LIBRESPOT_DEVICE_TYPE.*$/LIBRESPOT_DEVICE_TYPE=\"$LIBRESPOT_DEVICE_TYPE\"/" /etc/librespot.conf
#sed -i -r "s/^LIBRESPOT_INITIAL_VOLUME.*$/LIBRESPOT_INITIAL_VOLUME=\"$LIBRESPOT_INITIAL_VOLUME\"/" /etc/librespot.conf
#sed -i -r "s/^LIBRESPOT_ZEROCONF_PORT.*$/LIBRESPOT_ZEROCONF_PORT=\"$LIBRESPOT_ZEROCONF_PORT\"/" /etc/librespot.conf

echo "🌊 configuration done"
echo -e "\n---------------------\n"
