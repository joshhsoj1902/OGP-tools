#!/usr/bin/python
##
#https://forums.alliedmods.net/showthread.php?t=113188
##

import insert_common

post_bash="""cd %home_path%/left4dead2/addons/sourcemod/plugins
mv 'attachment.php?attachmentid=57824&d=1324205564' l4d2scores.smx
cd ../gamedata
wget -O l4d2scores.txt 'https://forums.alliedmods.net/attachment.php?attachmentid=57826&d=1375780526'

"""

insert_common.insert_addon(
    "Team Manager [1.3.0]",
    "https://forums.alliedmods.net/attachment.php?attachmentid=57824&d=1324205564",
    "left4dead2/addons/sourcemod/plugins",
    "plugin",
    "left4dead2_linux32",
    post_bash);
