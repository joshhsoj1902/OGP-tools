#!/usr/bin/python
##
#http://ulyssesmod.net/downloads.php
##

import insert_common

post_bash="""

CFG_FILE=%home_path%/garrysmod/cfg/server.cfg

cp -p $CFG_FILE $CFG_FILE.addon.bac

if echo "" | grep -q "sv_allowdownload" $CFG_FILE
  then 
    #FOUND
    sed -i "s/sv_allowdownload.*/sv_allowdownload 0/g" $CFG_FILE
  else 
    #NOT FOUND
    echo "sv_allowdownload 0" >> $CFG_FILE
fi

if echo "" | grep -q "sv_allowupload" $CFG_FILE
  then 
    #FOUND
    sed -i "s/sv_allowupload.*/sv_allowupload 0/g" $CFG_FILE
  else 
    #NOT FOUND
    echo "sv_allowupload 0" >> $CFG_FILE
fi

HOMEID=$(basename "%home_path%")
URL="http://%ip%/web/fastdl/"$HOMEID"/garrysmod/"
FILEPATH="/var/www/web/fastdl/"$HOMEID"/garrysmod/"
HOMEPATH="%home_path%"/garrysmod/
if echo "" | grep -q "sv_downloadurl" $CFG_FILE
  then 
    #FOUND
    sed -i "/sv_downloadurl/d" $CFG_FILE
    echo 'sv_downloadurl \"'$URL'\"' >> $CFG_FILE
  else 
    #NOT FOUND
    echo 'sv_downloadurl \"'$URL'\"' >> $CFG_FILE
fi

mkdir -p $FILEPATH

cp -rp $HOMEPATH/maps $FILEPATH
cp -rp $HOMEPATH/materials $FILEPATH
cp -rp $HOMEPATH/models $FILEPATH
cp -rp $HOMEPATH/sound $FILEPATH
cp -rp $HOMEPATH/particles $FILEPATH
cp -rp $HOMEPATH/resource $FILEPATH

"""

insert_common.update_addon(
    "Install & Update FastDL",
    "http://localhost/images/log.png",
    "",
    "plugin",
    "GarrysMod_linux32",
    post_bash);
