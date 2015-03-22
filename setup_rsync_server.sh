#this is only half the instructions, Full instructions here http://www.opengamepanel.org/faq.php?cat_id=5

$GAME_DIR="/home/ogpuser/games"

echo "use chroot = yes
read only = yes
[ogp_game_installer]
path = $GAME_DIR
comment = RSYNC source of OGP agent game installs
log file = /home/you/rsyncd.log
dont compress = *.pk3
refuse options = delete" >>/etc/rsyncd.conf

echo "TODO ADD THIS TO CRONTAB"
echo "3 48 * * * /usr/bin/rsync --archive --compress --update --verbose --delete rsync://rsync.opengamepanel.org/ogp_game_installer/ $GAME_DIR"


apt-get -y install xinetd;

echo "service rsync
{
disable = no
socket_type = stream
wait = no
user = root
server = /usr/bin/rsync
server_args = --daemon
log_on_failure += USERID
}" >> /etc/xinetd.d/rsync

/etc/init.d/xinetd restart;

echo "TODO ask if they want to rsync now"

echo "Run this to do sync now"
echo "/usr/bin/rsync --archive --compress --update --verbose --delete rsync://rsync.opengamepanel.org/ogp_game_installer/ $GAME_DIR"
