#!/bin/bash
ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
PARENT_PID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
BASH_PID=$(pgrep -P $PARENT_PID bash)
if [ -e "/proc/$BASH_PID/cwd" ]
then
    alacritty --working-directory "$(readlink /proc/$BASH_PID/cwd)"
else
    alacritty
fi
