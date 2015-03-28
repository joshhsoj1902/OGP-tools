#!/bin/bash

RSYNCDIR=/home/ogpuser/games

function update_game(){
  cd $1
  ./*rsync_setup.sh

  if [ "$?" -ne "0" ]; then
    echo "***********************"
    echo $1" UPDATE FAILED"
    echo "***********************"
    sleep 5
  fi

  cd ../  #This wont work if the sub script doesn't end in that folder
}

function install_game(){
  cp -rp $1/working/* $RSYNCDIR
}



if [ "$#" -ne 2 ]; then
    echo "Usage "$0" [update|install] [all|<game_name>]"
    exit -1
fi

if [[ $1 == "update" ]] || [[ $1 == "UPDATE" ]] || [[ $1 == "u" ]] || [[ $1 == "U" ]] ; then
  RUNMODE="U"
elif [[ $1 = "install" ]] || [[ $1 = "INSTALL" ]] || [[ $1 = "i" ]] || [[ $1 = "I" ]] ; then
  RUNMODE="I"
else
  echo "Invalid Runmode [update|install]"
  exit -1
fi

if [[ $2 == "all"  ]] ; then
  for f in */; do
    if [[ $RUNMODE == "U" ]] ; then
      update_game $f
    else
      install_game $f
    fi
  done
else
  if [[ $RUNMODE == "U" ]] ; then
    update_game $2
  else
    install_game $2
  fi
fi



