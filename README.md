# moode-artwork

Bash script for the [Moode audio player](https://moodeaudio.org) to send now playing album artwork to a running flaschen-taschen server. In my case, this allows displaying live album art from  on a 64x64 rgb led matrix connected to my raspberry pi.

## Notes

* send-image is from the [flaschen-tachen](https://github.com/hzeller/flaschen-taschen) project and was compiled in a unix environment
* This project was inspired by [kylejohnsonkj](https://github.com/kylejohnsonkj/ft-artwork) The majority of the credit goes to him, thank you!

![IMG_3660](https://user-images.githubusercontent.com/44140593/144626779-cf315b5a-a372-4f92-a864-1aeb8ddb8ce2.jpg)


## Requirement


- Moode audio
- Rspberry pi installed [flaschen-taschen](https://github.com/hzeller/flaschen-taschen) and [rpi-rgb-led-matrix](https://github.com/hzeller/rpi-rgb-led-matrix)
- 64x64 Led matrix (size is any if you want)

## Installation

### On Moode audio

#### Basic
1. turn on the metadata file for moode settings
2. put images in moode/img/empty to show the image when no music is playing
3. edit MAINDIR and COVERNAME at moode/src/mpd_cover.sh to suit your environment
* MAINDIR stands for music directory on your own mpd and COVERNAME stands for basic cover art name
4. edit SENDDIR at moode/src/send_cover.sh to suit your environment
* SENDDIR stands for local adrres of the aspberry pi with led matrix
5. run as bellow
```
source gen_env.sh
cd moode/src
source run.sh
```

#### With AirPlay
1. edit /etc/shairport-sync.conf as bellow

```
metadata =
{
 enabled = "yes"; // set this to yes to get Shairport Sync to solicit metadata from the source and to pass it on via a pipe
 include_cover_art = "yes"; // set to "yes" to get Shairport Sync to solicit cover art from the source and pass it via the pipe. You must also set "enabled" to "yes".
 cover_art_cache_directory = "/tmp/shairport-sync/.cache/coverart"; // artwork will be  stored in this directory if the dbus or MPRIS interfaces are enabled or if the MQTT client is in use. Set it to "" to prevent caching, which may be useful on some systems
 pipe_name = "/tmp/shairport-sync-metadata";
 pipe_timeout = 5000; // wait for this number of milliseconds for a blocked pipe to unblock before giving up
};

```
2. restart shairport-sync as bellow

```
sudo systemctl restart shairport-sync
```

#### With Spotify
1. Register [Spotify Developers](https://developer.spotify.com/dashboard)
2. make moode/src/.env file based on moode/src/env.sample
3. make moode/src/.sp_cache file based on moode/src/sp_cache.sample


### On Rspberry pi with led matrix
* get flaschen-taschen projext as below
```
git clone https://github.com/hzeller/flaschen-taschen.git
git clone https://github.com/hzeller/rpi-rgb-led-matrix.git
cp -r rpi-rgb-led-matrix/* flaschen-taschen/server/rgb-matrix
```

#### output on the terminal
*　It is recommended to try it out in a terminal before the production environment
```
cd flaschen-taschen/server
make FT_BACKEND=terminal
./ft-server -D64x64 --hd-terminal
```

#### output on a connected matrix
* LED matrix brightness note brightness.txt
```
cd flaschen-taschen/server
make FT_BACKEND=rgb-matrix
source cover.sh start # when start
source cover.sh stop # when stop
```
* or you can run simpley
```
sudo ./flaschen-taschen/server/ft-server --led-slowdown-gpio=2 --led-rows=64 --led-cols=64 --led-show-refresh --led-brightness=50
```

## Anything Else
* moode/src/send-image/moode are complied send-image from [flaschen-taschen/client](https://github.com/hzeller/flaschen-taschen/tree/master/client)
* by changing RESOLUTION in moode/src/send_cover.sh, you can change the resolution of the output image
* moode/txt/spotify.txt stands for the mode that is currently being played ans moode/txt/prev_song.txx stands for the artist-album that is currently being played

