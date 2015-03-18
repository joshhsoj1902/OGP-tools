#!/bin/bash

git pull origin;
echo "============="
echo "Tools Updated"
echo "============="

find -L /var/www/modules/config_games/server_configs/ -type l -delete;

ln -sf /usr/local/bin/OGP-tools/www/modules/config_games/server_configs/* /var/www/modules/config_games/server_configs/;
echo "======================"
echo "Server Configs Updated"
echo "======================"

#Temporary internal rsync server
echo "192.168.0.103" > /var/www/modules/gamemanager/rsync_sites_local.list

#It would be better if there was some way to know which games were added by me.
#this method doesn't support removing games later. It can only add games and 
#remove games before adding them right away again
while read p; do
  sed -i '/'$p'/d' /var/www/modules/gamemanager/rsync.list
  echo $p >> /var/www/modules/gamemanager/rsync.list
done <rsync_games.txt



echo "============="
echo "Rsync Updated"
echo "============="

echo "===="
echo "Done"
echo "===="
