#!/bin/bash

NAME=obe_hd

screen -d -m -S $NAME obecli
sleep 1
screen -p 0 -S $NAME -X stuff $'set input decklink\012'
screen -p 0 -S $NAME -X stuff $'set input opts card-idx=0\012'
screen -p 0 -S $NAME -X stuff $'set input opts video-format=1080i59.94\012'
screen -p 0 -S $NAME -X stuff $'set input opts video-connection=sdi\012'
screen -p 0 -S $NAME -X stuff $'set input opts audio-connection=embedded\012'
screen -p 0 -S $NAME -X stuff $'set obe opts system-type=lowestlatency\012'
screen -p 0 -S $NAME -X stuff $'probe input\012'
sleep 2
screen -p 0 -S $NAME -X stuff $'set stream opts 0:pid=1000,vbv-maxrate=4500,bitrate=4000,keyint=24,bframes=4,threads=1,format=avc,profile=high,level=3.2,aspect-ratio=16:9,intra-refresh=1\012'
screen -p 0 -S $NAME -X stuff $'set stream opts 1:pid=1001,bitrate=128,format=aac,aac-profile=he-aac-v1,aac-encap=latm\012'
screen -p 0 -S $NAME -X stuff $'set muxer opts pmt-pid=1002,ts-muxrate=6500000,ts-type=generic\012'
screen -p 0 -S $NAME -X stuff $'set output rtp\012'
screen -p 0 -S $NAME -X stuff $'set outputs 1\012'
screen -p 0 -S $NAME -X stuff $'set output opts 0:type=rtp,target=rtp://174.63.19.153:3000\012'
screen -p 0 -S $NAME -X stuff $'start\012'
screen -r $NAME
