#!/bin/bash
#
# nmpc 可以把mpc当前播放的歌曲标题通过notify形式显示出来的脚本
#
# Script by: Dachao Nong <ohosanna@gmail.com>

TIMEOUT=5000
ICONPATH='/usr/share/icons/Faenza'
PLAYINGICON=$ICONPATH/actions/32/audio-cd-new.png
PAUSEDICON=$ICONPATH/actions/32/gtk-media-pause.png
STOPEDICON=$ICONPATH/actions/32/gtk-media-stop.png
ERRORICON=$ICONPATH/status/32/error.png

err() {
   echo "$1"
   exit 1
}

usage() {
  echo "usage: nmpc [command]"
  echo
  echo "Commands:"
  echo "     play - Starts playing song."
  echo "     next - Starts playing next song on playlist"
  echo "     prev - Starts playing previous song."
  echo "     stop - Stops playing."
  echo "     toggle - Toggles between play and pause. If stopped starts  playing."
  echo "     -h, --help     - display this"
  exit
}

nmpc_play () {
  mpc play > /dev/null 2>&1
  MSGTITLE="MPC Playing: "
  MSGBODY="`mpc | sed -n '1p'`"
  MSGICON=$PLAYINGICON
}

nmpc_next () {
  mpc next > /dev/null 2>&1
  MSGTITLE="MPC Playing: "
  MSGBODY="`mpc | sed -n '1p'`"
  MSGICON=$PLAYINGICON
}

nmpc_prev () {
  mpc prev > /dev/null 2>&1
  MSGTITLE="MPC Playing: "
  MSGBODY="`mpc | sed -n '1p'`"
  MSGICON=$PLAYINGICON
}

nmpc_stop() {
  mpc stop > /dev/null 2>&1
  MSGTITLE="MPC Stoped!"
  MSGBODY=""
  MSGICON=$STOPEDICON
}

nmpc_toggle() {
  mpc toggle > /dev/null 2>&1
  if [ "`mpc | grep playing`" = "" ]; then
    MSGTITLE="MPC Paused!"
    MSGICON=$PAUSEDICON
  else
    MSGTITLE="MPC Playing: "
    MSGICON=$PLAYINGICON
  fi
  MSGBODY="`mpc | sed -n '1p'`"
}

if [ "`ps -A | grep mpd`" = "" ]; then
  notify-send -t $TIMEOUT -i $ERRORICON -h int:transient:1 "Error" "Oooop!! Mpd not running!"
  exit 1
else
  if [ "`mpc | grep -o playing`" = "" ] && [ "`mpc | grep -o paused`" = "" ]; then
    mpc play > /dev/null 2>&1
  else
    case "$1" in
      'play')
	nmpc_play
      ;;
      'next')
	nmpc_next
      ;;
      'prev')
	nmpc_prev
      ;;
      'stop')
	nmpc_stop
      ;;
      'toggle')
	nmpc_toggle
      ;;
      *)
	usage
	exit 1
      ;;
    esac
    notify-send -t $TIMEOUT -i $MSGICON -h int:transient:1 "$MSGTITLE" "$MSGBODY"
  fi
fi
