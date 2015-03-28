#!/bin/bash
#Build latest Spigot from source
#
#Details:
#http://www.spigotmc.org/wiki/spigot-installation/

OUTPUTDIR=done;
WORKINGDIR=working;
GAMENAME=minecraft;
PLATFORM=linux;

echo "======================================================================="
echo "RSYNC FOLDER SETUP FOR:   " $GAMENAME
echo ""
echo "======================================================================="
echo ""

BASEDIR=$WORKINGDIR/$GAMENAME/$PLATFORM;

mkdir -p $BASEDIR;
rm -r $OUTPUTDIR;

mkdir $WORKINGDIR;
cd $WORKINGDIR;

wget -N https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar;
java -jar BuildTools.jar;

if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo $1" Java Build error"
  echo "***********************"
  exit -1
else

  cd ../

  mkdir -p $OUTPUTDIR/$GAMENAME/$PLATFORM

  #TODO: Should I also download the latest offical MC?

  cp $WORKINGDIR/spigot-*jar $OUTPUTDIR/$GAMENAME/$PLATFORM
  cp $WORKINGDIR/craftbukkit*.jar $OUTPUTDIR/$GAMENAME/$PLATFORM

  cd $OUTPUTDIR/$GAMENAME/$PLATFORM

  ln -s spigot-*jar spigot.jar
  ln -s craftbukkit*.jar craftbukkit.jar

  cd ../../../
  chown -R 500:users $OUTPUTDIR;

fi
