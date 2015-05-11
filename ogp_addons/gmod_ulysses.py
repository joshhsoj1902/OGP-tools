#!/usr/bin/python
##
#http://ulyssesmod.net/downloads.php
##

import insert_common

post_bash="""cd %home_path%/garrysmod/addons
wget http://ulyssesmod.net/archive/ulx/ulx-v3_62.zip 
unzip ulx-v3_62.zip
rm -f ulx-v3_62.zip
rm -f ULib-v2_52.zip
"""

insert_common.update_addon(
    "ULib [2.52] + ULX [3.62]",
    "http://ulyssesmod.net/archive/ULib/ULib-v2_52.zip",
    "garrysmod/addons",
    "plugin",
    "GarrysMod_linux32",
    post_bash);
