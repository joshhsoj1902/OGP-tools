#!/bin/bash

DB_ADDR=localhost
DB_NAME=hlstatsx
DB_USER=hlstatsx
DB_PASS=$(mcookie)
WEBROOT=/var/www/stats/
TMPDIR=/tmp/hlx/
SCRIPTSDIR=/home/ogpuser/hlx_scripts/

mkdir -p $TMPDIR;
cd $TMPDIR;

wget https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/downloads/hlxce_1_6_19.tar.gz;

tar -zxvf hlxce_1_6_19.tar.gz;

mkdir -p $WEBROOT;
cp -rp web/* $WEBROOT;

mkdir -p $SCRIPTSDIR;
chown ogpuser:users $SCRIPTSDIR
cp -rp scripts/* $SCRIPTSDIR;


echo "========================="
echo "Creating Database"
echo "========================="
# create the database and user
mysql --defaults-extra-file=/etc/mysql/debian.cnf <<EOF
CREATE DATABASE $DB_NAME 
CHARACTER SET = utf8mb4 
COLLATE = utf8mb4_unicode_ci;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON $DB_NAME.*
TO $DB_USER@localhost
IDENTIFIED BY '$DB_PASS';
FLUSH PRIVILEGES;
EOF

echo "========================="
echo "Updating config files"
echo "========================="
#Web Panel
sed -i 's/("DB_ADDR", "")/("DB_ADDR", "'$DB_ADDR'")/g' $WEBROOT/config.php
sed -i 's/("DB_USER", "")/("DB_USER", "'$DB_USER'")/g' $WEBROOT/config.php
sed -i 's/("DB_PASS", "")/("DB_PASS", "'$DB_PASS'")/g' $WEBROOT/config.php
sed -i 's/("DB_NAME", "")/("DB_NAME", "'$DB_NAME'")/g' $WEBROOT/config.php

#Deamon
sed -i 's/DBHost ""/DBHost "'$DB_ADDR'"/g' $SCRIPTSDIR/hlstats.conf
sed -i 's/DBUsername ""/DBUsername "'$DB_USER'"/g' $SCRIPTSDIR/hlstats.conf
sed -i 's/DBPassword ""/DBPassword "'$DB_PASS'"/g' $SCRIPTSDIR/hlstats.conf
sed -i 's/DBName ""/DBName "'$DB_NAME'"/g' $SCRIPTSDIR/hlstats.conf

echo "========================="
echo "Adding Tables to Database"
echo "========================="
mysql -u$DB_USER -p$DB_PASS $DB_NAME < $TMPDIR/sql/install.sql

cd $SCRIPTSDIR
chmod +x hlstats-awards.pl hlstats.pl hlstats-resolve.pl run_hlstats

(crontab -u ogpuser -l ; echo "*/5 * * * * cd "$SCRIPTSDIR" && ./run_hlstats start >/dev/null 2>&1" 2> /dev/null) | sort - | uniq - | crontab -u ogpuser -
(crontab -u ogpuser -l ; echo "15 00 * * * cd "$SCRIPTSDIR" && ./hlstats-awards.pl >/dev/null 2>&1" 2> /dev/null) | sort - | uniq - | crontab -u ogpuser -

cd $SCRIPTSDIR/GeoLiteCity/
chmod +x install_binary.sh 
./install_binary.sh

rm -rf $WEBROOT/updater

echo "========================="
echo "Load /stats/ in a browser"
echo "user: admin"
echo "pass: 123456"
echo ""
echo "Go to '''Admin Users'''. Make yourself a new user. Give it admin privileges. Delete the old admin user. "
echo "========================="

