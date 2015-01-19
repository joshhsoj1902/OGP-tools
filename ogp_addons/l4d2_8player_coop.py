#!/usr/bin/python
##
#Left4Downtown2
#  https://forums.alliedmods.net/showthread.php?t=134032?t=134032
#
#Remove Lobby Reservation
#  https://forums.alliedmods.net/showthread.php?t=94415?t=94415
#
#Bebop
#  https://forums.alliedmods.net/showthread.php?p=999861
#
#Simple Welcome Msg
#  https://forums.alliedmods.net/showthread.php?p=880791
#
#Survivor Chat Select
#  https://forums.alliedmods.net/showpost.php?p=2199254&postcount=681
#
##
import insert_common

post_bash="""
echo "Left4Downtown2 Installed"

cd %home_path%/left4dead2/addons/sourcemod/plugins
wget -N -O l4dunreservelobby.smx https://forums.alliedmods.net/attachment.php?attachmentid=56932&d=1262977327
echo "Remove Lobby Reservation Installed"

cd %home_path%/left4dead2/addons/sourcemod/scripting
wget -N https://forums.alliedmods.net/attachment.php?attachmentid=54217&d=1259334888
unzip -o 'attachment.php?attachmentid=54217&d=1259334888'
rm -f bebop.smx
./compile.sh bebop.sp
mv compiled/bebop.smx ../plugins
echo "BeBop Installed"

cd %home_path%/left4dead2/addons/sourcemod/plugins
wget -N http://localhost/downloads/swm/simplewelcomemsg.smx
cd %home_path%/left4dead2/addons/sourcemod/translations
wget -N http://localhost/downloads/swm/simplewelcomemsg.phrases.txt
cd %home_path%/left4dead2/cfg/sourcemod
wget -N http://localhost/downloads/swm/plugin.simplewelcomemsg.cfg
echo "Simple Welcome Msg Installed"

cd %home_path%/left4dead2/addons/sourcemod/plugins
wget -N http://localhost/downloads/csm/survivor_chat_select.smx
cd %home_path%/left4dead2/cfg/sourcemod
wget -N http://localhost/downloads/csm/l4dscs.cfg
echo "Survivor Chat Select Installed"
"""

insert_common.insert_addon(
    "8 Player Co-op",
    "http://localhost/downloads/left4downtown2/left4downtown2.tar.gz",
    "left4dead2",
    "plugin",
    "left4dead2_linux32",
    post_bash);
