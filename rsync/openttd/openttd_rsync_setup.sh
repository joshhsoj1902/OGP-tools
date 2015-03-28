#!/bin/bash
#Create the openttd rsync folder
#
#DOWNLOADS:
#http://www.openttd.org/en/download-stable
#http://www.openttd.org/download-opengfx
#http://www.openttd.org/download-opensfx
#http://www.openttd.org/download-openmsx

OPENTTDVERSION=1.4.4;
OPENGFXVERSION=0.5.0;
OPENSFXVERSION=0.2.3;
OPENMSXVERSION=0.3.1;

WORKINGDIR=working;
GAMENAME=openttd;
PLATFORM=linux;

echo "======================================================================="
echo "RSYNC FOLDER SETUP FOR:   " $GAMENAME  
echo ""
echo "OPENTTD VERSION: "$OPENTTDVERSION
echo "OPENGFX VERSION: "$OPENGFXVERSION
echo "OPENSFX VERSION: "$OPENSFXVERSION
echo "OPENMSX VERSION: "$OPENMSXVERSION
echo "======================================================================="
echo ""

BASEDIR=$WORKINGDIR/$GAMENAME/$PLATFORM;

mkdir -p $BASEDIR;
cp openttd_launcher.sh openttd.cfg $BASEDIR;

#cd $BASEDIR;

#########
#OPENTTD#
#########
wget -N -P $WORKINGDIR http://binaries.openttd.org/releases/$OPENTTDVERSION/openttd-$OPENTTDVERSION-linux-generic-amd64.tar.gz;

if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo "OPENTTD DOWNLOAD FAILED"
  echo "***********************"
  exit -1
fi

cp $WORKINGDIR/openttd*.tar.gz $BASEDIR/;
tar -zxvf $BASEDIR/openttd*.tar.gz -C $BASEDIR;
rm $BASEDIR/openttd*.tar.gz;
mv $BASEDIR/openttd-* $BASEDIR/openttd-dir; # Looks like this:  openttd-1.4.4-linux-generic-amd64
mv $BASEDIR/openttd-dir/* $BASEDIR/;
rmdir $BASEDIR/openttd-dir*;


#cd baseset;

#########
#OPENGFX#
#########
wget -N -P $WORKINGDIR http://binaries.openttd.org/extra/opengfx/$OPENGFXVERSION/opengfx-$OPENGFXVERSION-all.zip;

if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo "OPENGFX DOWNLOAD FAILED"
  echo "***********************"
  exit -1
fi

cp $WORKINGDIR/opengfx*.zip $BASEDIR/baseset/;
unzip $BASEDIR/baseset/opengfx*.zip -d $BASEDIR/baseset/;
tar -xvf $BASEDIR/baseset/opengfx*.tar -C $BASEDIR/baseset/; 
rm $BASEDIR/baseset/opengfx*.zip $BASEDIR/baseset/opengfx*.tar;
mv $BASEDIR/baseset/opengfx* $BASEDIR/baseset/opengfx;

#########
#OPENSFX#
#########
wget -N -P $WORKINGDIR http://binaries.openttd.org/extra/opensfx/$OPENSFXVERSION/opensfx-$OPENSFXVERSION-all.zip;

if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo "OPENSFX DOWNLOAD FAILED"
  echo "***********************"
  exit -1
fi

cp $WORKINGDIR/opensfx*.zip  $BASEDIR/baseset/;
unzip $BASEDIR/baseset/opensfx*.zip -d $BASEDIR/baseset/;
rm $BASEDIR/baseset/opensfx*.zip;
mv $BASEDIR/baseset/opensfx* $BASEDIR/baseset/opensfx;

#########
#OPENMSX#
#########
wget -N -P $WORKINGDIR/ http://binaries.openttd.org/extra/openmsx/$OPENMSXVERSION/openmsx-$OPENMSXVERSION-all.zip;

if [ "$?" -ne "0" ]; then
  echo "***********************"
  echo "OPENMSX DOWNLOAD FAILED"
  echo "***********************"
  exit -1
fi

cp $WORKINGDIR/openmsx*.zip $BASEDIR/baseset/;
unzip $BASEDIR/baseset/openmsx*.zip -d $BASEDIR/baseset/;
rm $BASEDIR/baseset/openmsx*.zip;
mv $BASEDIR/baseset/openmsx* $BASEDIR/baseset/openmsx;


chown -R 500:users $WORKINGDIR;


echo ""
echo "======================================================================="
echo "RSYNC FOLDER CREATED"
echo "======================================================================="
