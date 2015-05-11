#!/usr/bin/python
##
#Details!
#  http://www.opengamepanel.org/forum/viewthread.php?thread_id=2408 
#
##
import insert_common

post_bash="""

cd /home/ogpuser/OGP/steamcmd
echo @ShutdownOnFailedCommand 0 > gmod_contents.txt
echo @NoPromptForPassword 1 >> gmod_contents.txt
echo login anonymous >> gmod_contents.txt
echo // Counter Strike: Source >> gmod_contents.txt
echo force_install_dir /home/ogpuser/OGP_User_Files/m_css >> gmod_contents.txt
echo app_update 232330 validate >> gmod_contents.txt
//echo // Day of Defeat: Source >> gmod_contents.txt
//echo force_install_dir /home/ogpuser/OGP_User_Files/m_dods >> gmod_contents.txt
//echo app_update 232290 validate >> gmod_contents.txt
echo // Half Life 2: Deathmatch >> gmod_contents.txt
echo force_install_dir /home/ogpuser/OGP_User_Files/m_hl2dm >> gmod_contents.txt
echo app_update 232370 validate >> gmod_contents.txt
//echo // Team Fortress 2 >> gmod_contents.txt
//echo force_install_dir /home/ogpuser/OGP_User_Files/m_tf2 >> gmod_contents.txt
//echo app_update 232250 validate >> gmod_contents.txt
//echo // Left 4 Dead 2 content >> gmod_contents.txt
//echo force_install_dir /home/ogpuser/OGP_User_Files/m_l4d2 >> gmod_contents.txt
//echo app_update 222860 validate >> gmod_contents.txt
echo quit >> gmod_contents.txt
./steamcmd.sh +runscript gmod_contents.txt

ln -s /home/ogpuser/OGP_User_Files/m_css /home/ogpuser/gmod_content/css
ln -s /home/ogpuser/OGP_User_Files/m_dods /home/ogpuser/gmod_content/dods
ln -s /home/ogpuser/OGP_User_Files/m_hl2dm /home/ogpuser/gmod_content/hl2dm
ln -s /home/ogpuser/OGP_User_Files/m_tf2 /home/ogpuser/gmod_content/tf2
ln -s /home/ogpuser/OGP_User_Files/m_l4d2 /home/ogpuser/gmod_content/l4d2

cd %home_path%/garrysmod/cfg
wget -O mount.cfg http://localhost/downloads/gmod/mount.cfg

"""

insert_common.update_addon(
    "Advanced FREE Content installation",
    "http://localhost/downloads/gmod/mountdepots.txt",
    "garrysmod/cfg",
    "plugin",
    "GarrysMod_linux32",
    post_bash);
