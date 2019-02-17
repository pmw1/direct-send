#!/bin/bash


PROFILE=$1


if [ -n "$PROFILE" ]
	then
	docker run \
		--name="obe" \
		-v /home/kevin/docker/obe-rt-send/hostfiles:/home/default/hostfiles \
		-v /home/kevin/docker/obe-rt-send/hostfiles/profiles:/home/default/hostfiles/profiles \
		-v /home/kevin/recorded-video:/home/default/recorded-video  \
		-e PROFILE=$PROFILE \
		-i -t  \
		--device /dev/blackmagic/io0 \
		--entrypoint="/bin/bash"\
		pmw1/obe-rt-send
fi
