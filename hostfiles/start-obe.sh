#!/bin/bash
NAME=obe
screen  -d -m -S $NAME obecli
sleep 1
screen -p 0 -S $NAME -X stuff $"set input decklink\012"
screen -p 0 -S $NAME -X stuff $"set input opts card-idx=0\012"
screen -p 0 -S $NAME -X stuff $"set input opts video-format=1080i59.94\012"
screen -p 0 -S $NAME -X stuff $"set input opts video-connection=sdi\012"
screen -p 0 -S $NAME -X stuff $"set input opts audio-connection=embedded\012"
screen -p 0 -S $NAME -X stuff $"set obe opts system-type=lowestlatency\012"
screen -p 0 -S $NAME -X stuff $"probe input\012"
sleep 2
screen -p 0 -S $NAME -X stuff $"set stream opts 0:pid=1000,vbv-maxrate=7700,bitrate=7500,keyint=30,bframes=1,threads=4,format=avc,profile=main,level=3.2,aspect-ratio=16:9,intra-refresh=1\012"
screen -p 0 -S $NAME -X stuff $"set stream opts 1:pid=1001,bitrate=256,format=aac,aac-profile=aac-lc,aac-encap=latm\012"
screen -p 0 -S $NAME -X stuff $"set muxer opts ts-type=generic,ts-muxrate=8200000\012"
screen -p 0 -S $NAME -X stuff $"set output udp\012"
screen -p 0 -S $NAME -X stuff $"set outputs 1\012"
screen -p 0 -S $NAME -X stuff $"set output opts 0:target=udp://72.0.154.251:3000\012"
screen -p 0 -S $NAME -X stuff $"start\012"
