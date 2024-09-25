# Spotify Stream

Stream your Spotify collection

## What?

A docker image that creates a new device on Spotify (called "Daemon"), which streams what you're listening to Icecast.

It uses the excellent [spotifyd](https://github.com/Spotifyd/spotifyd).

## How?

docker-compose file:
```
services:
  spotify-stream:
    container_name: spotify-stream
    environment:
    - SPOTIFY_DEVICE_NAME=Daemon
    # possible values: audiodongle, avr, computer, smartphone, speaker, stb, tablet, tv
    - SPOTIFY_DEVICE_TYPE=computer
    - SPOTIFY_INITIAL_VOLUME=90
    - SPOTIFY_ZEROCONF_PORT=1234
    - ICECAST_USERNAME=admin
    - ICECAST_PASSWORD=spotify
    - DARKICE_MOUNT_POINT=spotify
    - DARKICE_NAME=Spotify\ Stream
    - DARKICE_DESCRIPTION=Streaming\ Spotify\ in\ realtime
    image: meiser79/spotify-stream:latest
    network_mode: host
    restart: unless-stopped
```

Then connect to the stream via `http://my.ip.address:8000/spotify`.

## Disclaimer

[spotifyd](https://github.com/Spotifyd/spotifyd) binary was compiled via `cargo build --release --features pulseaudio_backend` and was included here to accelerate building time. You should compile it by yourself.

## Legal
Spotify Stream is licensed under MIT, it's based on [Trugamr's project](https://github.com/Trugamr/spotify-stream).

SPOTIFY is a trademark of Spotify AB.
