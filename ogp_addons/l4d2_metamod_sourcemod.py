#!/usr/bin/python
##
#http://opengamepanel.org/forum/viewthread.php?thread_id=2243
##

import insert_common

post_bash="""cd %home_path%/left4dead2
wget http://www.gsptalk.com/mirror/sourcemod/mmsource-1.10.4-linux.tar.gz
tar -zxvf mmsource-1.10.4-linux.tar.gz
echo "\"Plugin\"">%home_path%/left4dead2/addons/metamod.vdf
echo "{">>%home_path%/left4dead2/addons/metamod.vdf
echo    "\"file\"   \"../left4dead2/addons/metamod/bin/server\"">>%home_path%/left4dead2/addons/metamod.vdf
echo "}">>%home_path%/left4dead2/addons/metamod.vdf
rm -f %home_path%/left4dead2/addons/metamod/sourcemod.vdf
echo "sm addons/sourcemod/bin/sourcemod_mm">>%home_path%/left4dead2/addons/metamod/metaplugins.ini"""

insert_common.update_addon(
    "Metamod Source [1.10.4] + Sourcemod [1.6.3]",
    "http://cdn.probablyaserver.com/sourcemod/sourcemod-1.6.3-linux.tar.gz",
    "left4dead2",
    "plugin",
    "left4dead2_linux32",
    post_bash);
