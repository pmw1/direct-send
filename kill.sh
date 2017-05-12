#!/bin/bash
PID=$(fuser ~/py-apps/direct-send/direct-send | awk '{print $1}')
echo "kill $PID"
sudo kill $PID
