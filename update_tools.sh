#!/bin/bash

git pull origin;

find -L /var/www/modules/config_games/server_configs/ -type l -delete;

ln -sf /usr/local/bin/OGP-tools/www/modules/config_games/server_configs/* /var/www/modules/config_games/server_configs/;
