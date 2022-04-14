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

echo "🌊 configuration done"
echo -e "\n---------------------\n"