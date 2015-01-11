#!/bin/bash

mkdir -p /home/ogpuser/OGP_User_Files/7dtd;
bash /usr/local/bin/OGP-tools/7dtd/ogp_7dtd_bootstrap.sh -i -u ogpuser -g users -p /home/ogpuser/OGP_User_Files/7dtd;
. /etc/bash_completion;
