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

echo "===="
echo "Done"
echo "===="
