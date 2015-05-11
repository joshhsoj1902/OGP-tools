#!/usr/bin/python
##
#http://ulyssesmod.net/downloads.php
##

import insert_common

post_bash="""

CFG_FILE=%home_path%/garrysmod/cfg/server.cfg

cp -p $CFG_FILE $CFG_FILE.addon.bac

sed -i "/sv_allowdownload/d" $CFG_FILE
sed -i "/sv_allowupload/d" $CFG_FILE
sed -i "/sv_downloadurl/d" $CFG_FILE


HOMEID=$(basename "%home_path%")
FILEPATH="/var/www/web/fastdl/"$HOMEID""
echo $FILEPATH

rm -rf $FILEPATH

"""

insert_common.insert_addon(
    "Remove FastDL",
    "http://localhost/images/log.png",
    "",
    "plugin",
    "GarrysMod_linux32",
    post_bash);
