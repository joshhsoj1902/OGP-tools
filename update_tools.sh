#!/bin/bash

git pull origin;
echo "Tools Updated"

find -L /var/www/modules/config_games/server_configs/ -type l -delete;

ln -sf /usr/local/bin/OGP-tools/www/modules/config_games/server_configs/* /var/www/modules/config_games/server_configs/;
echo "Server Configs Updated"
