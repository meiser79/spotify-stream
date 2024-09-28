# Spotify Stream

Stream your Spotify collection

## What?

A docker image that creates a new device on Spotify (called "Daemon"), which streams what you're listening to Icecast.

It uses the excellent [librespot](https://github.com/librespot-org/librespot).

## How?

docker-compose file:
```
services:
  spotify-stream:
    container_name: spotify-stream
    environment:
    - LIBRESPOT_DEVICE_NAME=Daemon
    # possible values: audiodongle, avr, computer, smartphone, speaker, stb, tablet, tv
    - LIBRESPOT_DEVICE_TYPE=computer
    - LIBRESPOT_CACHE=/spotify-stream/cache
    - LIBRESPOT_INITIAL_VOLUME=90
    - LIBRESPOT_ZEROCONF_PORT=1234
    - ICECAST_ADMIN=contact@domain.com
    - ICECAST_HOSTNAME=my.ip.address
    - ICECAST_LOCATION=New\ York
    - ICECAST_USERNAME=admin
    - ICECAST_PASSWORD=spotify
    - DARKICE_MOUNT_POINT=spotify
    - DARKICE_NAME=Spotify\ Stream
    - DARKICE_DESCRIPTION=Streaming\ Spotify\ in\ realtime
    image: meiser79/spotify-stream:latest
    network_mode: host
    restart: unless-stopped
    volumes:
    - ./cache:/spotify-stream/cache
```

Then connect to the stream via `http://my.ip.address:8000/spotify`.

## Disclaimer

[librespot](https://github.com/librespot-org/librespot) binary was compiled via `cargo build --release --no-default-features --features "pulseaudio-backend"` and was included here to accelerate building time. You should compile it by yourself.

## Legal
Spotify Stream is licensed under MIT, it's based on [Trugamr's project](https://github.com/Trugamr/spotify-stream).

SPOTIFY is a trademark of Spotify AB.
