#!/usr/bin/python
##
#Details!
#  http://danielgibbs.co.uk/2014/08/garrys-mod-linux-server-glibc_2-15/ 
#
##
import insert_common

post_bash="""
wget http://illy.bz/fi/7dtd/server_fixes.tar.gz
tar -zxvf server_fixes.tar.gz 
rm server_fixes.tar.gz
echo '7DaysToDie_Data/Managed/'
"""

insert_common.insert_addon(
    "Allocs Server Fixes",
    "https://www.google.ca/images/nav_logo195.png",
    "",
    "plugin",
    "7daystodie_linux32",
    post_bash);
