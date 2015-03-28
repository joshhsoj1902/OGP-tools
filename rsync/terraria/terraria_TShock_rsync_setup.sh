#!/bin/bash
#Create the terraria (tshock) rsync folder

TSHOCKVERSION=v4.2.6

OUTPUTDIR=done;
WORKINGDIR=working;
GAMENAME=terraria;
PLATFORM=linux;

echo "======================================================================="
echo "RSYNC FOLDER SETUP FOR:   " $GAMENAME
echo ""
echo "TSHOCK VERSION: "$TSHOCKVERSION
echo "======================================================================="
echo ""

rm -r $OUTPUTDIR;
mkdir $OUTPUTDIR;
mkdir -p $WORKINGDIR/$GAMENAME/$PLATFORM;

cp terraria_tshock_launcher.sh $WORKINGDIR/$GAMENAME/$PLATFORM;

#Adding -N here causes 403 errors
wget -P $WORKINGDIR https://github.com/NyxStudios/TShock/releases/download/$TSHOCKVERSION/tshock_release.zip;
if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo "TSHOCK DOWNLOAD FAILED"
  echo "***********************"
  exit -1
fi


unzip -o $WORKINGDIR/tshock_release.zip -d $WORKINGDIR/$GAMENAME/$PLATFORM/;
mkdir $WORKINGDIR/$GAMENAME/$PLATFORM/Worlds;
rm $WORKINGDIR/tshock_release.zip

cp -rp $WORKINGDIR/$GAMENAME $OUTPUTDIR;
chown -R 500:users $OUTPUTDIR;
