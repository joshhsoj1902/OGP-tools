#!/usr/bin/python
##
#Details!
#  http://danielgibbs.co.uk/2014/08/garrys-mod-linux-server-glibc_2-15/ 
#
##
import insert_common

post_bash="""

cd %home_path%/bin
wget -N wget https://github.com/dgibbs64/linuxgameservers/raw/master/GarrysMod/dependencies/libc.so.6
wget https://github.com/dgibbs64/linuxgameservers/raw/master/GarrysMod/dependencies/libm.so.6
wget https://github.com/dgibbs64/linuxgameservers/raw/master/GarrysMod/dependencies/libpthread.so.0

"""

insert_common.insert_addon(
    "Debian GLIBC 2.15 Patch",
    "https://github.com/dgibbs64/linuxgameservers/raw/master/GarrysMod/dependencies/libstdc++.so.6",
    "",
    "plugin",
    "GarrysMod_linux32",
    post_bash);
