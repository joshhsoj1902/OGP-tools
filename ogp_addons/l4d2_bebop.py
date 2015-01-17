#!/usr/bin/python
##
#https://forums.alliedmods.net/showthread.php?p=999861
##

import insert_common

post_bash="""cd %home_path%/left4dead2/addons/sourcemod/scripting
unzip -o 'attachment.php?attachmentid=54217&d=1259334888'
rm -f bebop.smx
./compile.sh bebop.sp
mv compiled/bebop.smx ../plugins
"""

insert_common.insert_addon(
    "Bebop [0.2]",
    "https://forums.alliedmods.net/attachment.php?attachmentid=54217&d=1259334888",
    "left4dead2/addons/sourcemod/scripting",
    "plugin",
    "left4dead2_linux32",
    post_bash);
