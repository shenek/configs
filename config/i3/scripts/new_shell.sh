#!/bin/bash
ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
PARENT_PID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
BASH_PID=$(pgrep -P $PARENT_PID bash)
if [ -e "/proc/$BASH_PID/cwd" ]
then
    TERMINAL=urxvt i3-sensible-terminal -cd "$(readlink /proc/$BASH_PID/cwd)"
else
    TERMINAL=urxvt i3-sensible-terminal
fi
