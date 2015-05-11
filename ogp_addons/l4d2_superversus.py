#!/usr/bin/python
##
#https://forums.alliedmods.net/showthread.php?t=92713?t=92713
##

import insert_common

post_bash="""cd %home_path%/left4dead2/addons/sourcemod/plugins
mv 'vbcompiler.php?file_id=54755' l4d_superversus.smx
cd %home_path%/left4dead2/cfg/sourcemod
wget -O l4d_superversus.cfg 'https://forums.alliedmods.net/attachment.php?attachmentid=54296&d=1259500245'
"""

insert_common.update_addon(
    "SuperVersus [1.5.4]",
    "http://www.sourcemod.net/vbcompiler.php?file_id=54755",
    "left4dead2/addons/sourcemod/plugins",
    "plugin",
    "left4dead2_linux32",
    post_bash);
