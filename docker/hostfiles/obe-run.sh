#!/bin/bash


if [ -n $PROFILE ]
	then
	echo "Using profile: $PROFILE"
	source hostfiles/profiles/$PROFILE
fi	

NAME=obe_hd

screen -d -m -S $NAME obecli
sleep 1
screen -p 0 -S $NAME -X stuff $"set input decklink\012"
screen -p 0 -S $NAME -X stuff $"set input opts card-idx=0\012"
screen -p 0 -S $NAME -X stuff $"set input opts video-format=1080i59.94\012"
screen -p 0 -S $NAME -X stuff $"set input opts video-connection=sdi\012"
screen -p 0 -S $NAME -X stuff $"set input opts audio-connection=embedded\012"
screen -p 0 -S $NAME -X stuff $"set obe opts system-type=lowestlatency\012"
screen -p 0 -S $NAME -X stuff $"probe input\012"
sleep 2
screen -p 0 -S $NAME -X stuff $"set stream opts 0:pid=$VPID,vbv-maxrate=$VMAXBITRATE,bitrate=$VBITRATE,keyint=$VKEYINT,bframes=$VBFRAMES,threads=$VTHREADS,format=$VFORMAT,profile=$VPROFILE,level=VLEVEL,aspect-ratio=$VASPECTRATIO,intra-refresh=$VINTRAREFRESH\012"
screen -p 0 -S $NAME -X stuff $"set stream opts 1:pid=$APID,bitrate=$ABITRATE,format=$AFORMAT,aac-profile=$APROFILE,aac-encap=$AACENCAP\012"
screen -p 0 -S $NAME -X stuff $"set muxer opts pmt-pid=1002,ts-muxrate=$MUXRATE,ts-type=$TSTYPE\012"
screen -p 0 -S $NAME -X stuff $"set output $MODE\012"
screen -p 0 -S $NAME -X stuff $"set outputs 1\012"
screen -p 0 -S $NAME -X stuff $"set output opts 0:type=$MODE,target=$MODE://$DEST:$PORT\012"
screen -p 0 -S $NAME -X stuff $"start\012"
screen -r $NAME
