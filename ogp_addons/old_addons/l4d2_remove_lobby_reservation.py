#!/usr/bin/python
##
#https://forums.alliedmods.net/showthread.php?t=94415?t=94415
##
import insert_common

post_bash="""cd %home_path%/left4dead2/addons/sourcemod/plugins
mv 'attachment.php?attachmentid=56932&d=1262977327' l4dunreservelobby.smx
"""

insert_common.insert_addon(
    "Remove Lobby Reservation (When Full) [1.1.1]",
    "https://forums.alliedmods.net/attachment.php?attachmentid=56932&d=1262977327",
    "left4dead2/addons/sourcemod/plugins",
    "plugin",
    "left4dead2_linux32",
    post_bash);
