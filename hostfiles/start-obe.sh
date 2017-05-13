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
screen -p 0 -S $NAME -X stuff $"set stream opts 0:pid=1000,vbv-maxrate=4600,bitrate=4500,keyint=30,bframes=1,threads=4,format=avc,profile=main,level=3.2,aspect-ratio=16:9,intra-refresh=1\012"
screen -p 0 -S $NAME -X stuff $"set stream opts 1:pid=1001,bitrate=128,format=aac,aac-profile=aac-lc,aac-encap=latm\012"
screen -p 0 -S $NAME -X stuff $"set muxer opts ts-type=generic,ts-muxrate=5000000\012"
screen -p 0 -S $NAME -X stuff $"set output udp\012"
screen -p 0 -S $NAME -X stuff $"set outputs 1\012"
screen -p 0 -S $NAME -X stuff $"set output opts 0:target=udp://204.13.45.187:3001\012"
screen -p 0 -S $NAME -X stuff $"start\012"
screen -r
