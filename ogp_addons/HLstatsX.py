#!/usr/bin/python
##
#https://forums.alliedmods.net/forumdisplay.php?f=156
##

import insert_common

post_bash="""cd %home_path%/left4dead2/addons/hlx
cp -rp sourcemod ../
rm -rf %home_path%/left4dead2/addons/hlx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-aoc.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-css.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-ddd.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-dods.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-ges.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-hl2mp.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-ins.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-neotokyo.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-nucleardawn.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-pvkii.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-tf2.smx
rm -f %home_path%/left4dead2/addons/sourcemod/plugins/superlogs-zps.smx
"""

insert_common.insert_addon(
    "HLX stats client [1.6.19]",
    "https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/downloads/hlxce_1_6_19.tar.gz",
    "left4dead2/addons/hlx",
    "plugin",
    "left4dead2_linux32",
    post_bash);
