#!/bin/bash

# Based on r204 of alloc's bootstrap script found here:
# https://7dtd.illy.bz/browser/bootstrapper/bootstrap.sh

# Script modified to support a user being passed into the script and support
# a home directory passed in.

VERSION=5

if [ `id -u` -ne 0 ]; then
	echo "This script has to be run as root!"
	exit 1
fi


ADDCRONJOBS=0
RUNINSTALL=0
INSTALLOPTIONALDEPS=0

INSTALLDIR="/home/sdtd"
ADDUSER=1
SDTD_USER="sdtd"
SDTD_GROUP="sdtd"

DEPENDENCIES="gcc wget rsync xmlstarlet libc6-dev netcat"

if [ -n "$(command -v apt-get)" ]; then
	ISDEBIAN=1
else
	ISDEBIAN=0
fi

if [ $(uname -m) == 'x86_64' ]; then
	IS64BIT=1
else
	IS64BIT=0
fi

if [ $IS64BIT -eq 1 ]; then
	DEPENDENCIES="$DEPENDENCIES lib32gcc1"
fi

showHelp() {
	echo "7dtd bootstrapper version $VERSION"
	echo
	echo "Usage: ./bootstrap.sh [-h] [-c] -i"
	echo "Parameters:"
	echo "  -h   Print this help screen and exit"
#	echo "  -o   Install optional dependencies ($OPTDEPENDENCIES)"
	echo "  -c   Enable cron job for automatic backups"
	echo "  -i   Required to actually start the installation"
	echo "  -p   (Optional) Custom install directory (Must exist already)"
	echo "  -u   (Optional) Custom user (Must exist already)"
	echo "  -g   (Optional) Custom group for the user (Must exist already)"
}

intro() {
	echo
	echo "7DtD Linux dedicated server bootstrapper"
	echo
	echo "This will install a 7DtD server according to the information"
	echo "given on:"
	echo "   https://7dtd.illy.bz/"
	echo
	read -p "Press enter to continue"
	echo -e "\n=============================================================\n\n"
}

nonDebianWarning() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo "NOTE: It seems like this system is not based on Debian."
		echo "Although installation of the scripts and SteamCMD/7dtd"
		echo "will work the installed management scripts will probably"
		echo "fail because of missing dependencies. Make sure you check"
		echo "the website regarding the prerequisites"
		echo "(https://7dtd.illy.bz)."
		echo
		echo "Do you want to continue anyway?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes)
					echo "Continuing..."
					break;;
				No)
					echo "Aborting."
					exit 0
					;;
			esac
		done
		echo -e "\n=============================================================\n\n"
	fi
}

installAptDeps() {
	echo -e "Installing dependencies\n"
	if [ $IS64BIT -eq 1 ]; then
		dpkg --add-architecture i386
	fi
	apt-get update
	apt-get install $DEPENDENCIES
	echo -e "\n=============================================================\n\n"
}

installOptionalDeps() {
	echo -e "Installing optional dependencies\n"
	apt-get install $OPTDEPENDENCIES
	echo -e "\n=============================================================\n\n"
}

checkSetupDeps() {
	for DEP in gcc wget tr rsync xmlstarlet; do
		which $DEP > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "\"$DEP\" not installed. Please install it and run this script again."
			exit 1
		fi
	done
	
	ldconfig -p | grep ld-linux | grep "(ELF)" > /dev/null
	if [ $? -ne 0 ]; then
		echo "WARNING: There probably is no 32 Bit version of ld-linux installed."
		echo "This is most probably part of a 32 Bit version of a glibc-package."
		echo
		echo "It will result in errors trying to run SteamCMD if this library is not available!."
		echo "Do you want to continue anyway?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes)
					break;;
				No)
					echo "Aborting."
					exit 1
					;;
			esac
		done
	fi

	ldconfig -p | grep gcc | grep -v 64 > /dev/null
	if [ $? -ne 0 ]; then
		echo "WARNING: There probably is no 32 Bit version of libgcc installed."
		echo
		echo "It will result in errors trying to run SteamCMD if this library is not available!"
		echo "Do you want to continue anyway?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes)
					break;;
				No)
					echo "Aborting."
					exit 1
					;;
			esac
		done
	fi
}

setupUser() {
#	echo -e "Setting up user and group \"sdtd\"\n"
	if [ $ADDUSER -eq 1 ]; then
        	useradd -d /home/sdtd -m -r -s /bin/bash -U $SDTD_USER
	fi

	#Allow the user to 7dtd as root 9used by open game panal) 
        echo $SDTD_USER" ALL = (root) NOPASSWD: /usr/local/bin/7dtd.sh" > /etc/sudoers.d/7dtd

	echo -e "\n=============================================================\n\n"
}

installManagementScripts() {
	echo -e "Downloading and installing management scripts\n"
	wget -nv http://illy.bz/fi/7dtd/management_scripts.tar.gz -O /tmp/management_scripts.tar.gz
	tar --touch --no-overwrite-dir -xzf /tmp/management_scripts.tar.gz -C /

	chown root.root /etc/7dtd.conf
	chmod 0600 /etc/7dtd.conf

	sed -i "s/SDTD_USER=sdtd/SDTD_USER=$SDTD_USER/" /etc/7dtd.conf
	sed -i "s/SDTD_GROUP=sdtd/SDTD_GROUP=$SDTD_GROUP/" /etc/7dtd.conf

	chown sdtd.sdtd /home/sdtd -R

	chown root.root /etc/init.d/7dtd.sh
	chown root.root /etc/bash_completion.d/7dtd
	chown root.root /etc/cron.d/7dtd-backup
	chown root.root /usr/local/bin/7dtd.sh
	chown root.root /usr/local/lib/7dtd -R
	chmod 0755 /etc/init.d/7dtd.sh
	chmod 0755 /etc/bash_completion.d/7dtd
	chmod 0755 /etc/cron.d/7dtd-backup
	chmod 0755 /usr/local/bin/7dtd.sh
	chmod 0755 /usr/local/lib/7dtd -R

	if [ $ISDEBIAN -eq 1 ]; then
		update-rc.d 7dtd.sh defaults
	fi
	
	echo
	echo "Compiling start-stop-daemon"
	cd /usr/local/lib/7dtd/start-stop-daemon

	gcc -Wall -Wextra -Wno-return-type -o start-stop-daemon start-stop-daemon.c
	chown root.root start-stop-daemon
	chmod 0755 start-stop-daemon

	echo -e "\n=============================================================\n\n"
}

setSteamLoginData() {
	echo -e "Steam account data\n"
	echo "Please enter your Steam login data for SteamCMD to get the 7dtd-server files:"
	read -p "Steam username: " username
	read -s -p "Steam password: " password
	sed -i "s/export STEAM_USER=/export STEAM_USER=$username/" /etc/7dtd.conf
	sed -i "s/export STEAM_PASS=/export STEAM_PASS=$password/" /etc/7dtd.conf
	echo -e "\n=============================================================\n\n"
}

installSteamCmdAndSDTD() {
	echo -e "Installing SteamCMD and 7DtD\n"

        sed -i "s|/home/sdtd|"$INSTALLDIR"|" /etc/7dtd.conf

	7dtd.sh updateengine
	echo -e "\n=============================================================\n\n"
}

addCronJobs() {
	echo -e "Enabling backup cron job\n"

	echo -e "By default a backup of the save folder will be created once"
	echo -e "  per hour. This can be changed in /etc/cron.d/7dtd-backup."
	
	cat /etc/cron.d/7dtd-backup | tr -d '#' > /tmp/7dtd-backup
	cp /tmp/7dtd-backup /etc/cron.d

	echo -e "\n=============================================================\n\n"
}

finish() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo
		echo "You are not running a Debian based distribution."
		echo "The following things should manually be checked:"
		echo " - Existence of prerequsities"
		echo " - Running the init-script on boot"
	else
		echo -e "\n ALL DONE"
	fi

	echo
	echo -e "You can now continue setting up instances as explained on the website:"
	echo -e "  https://7dtd.illy.bz/wiki/Instance%20management"
	echo
	echo -e "You might also need to manually enable bash auto completion, refer to:"
	echo -e "  https://7dtd.illy.bz/wiki/Installation#Bashcompletion"
	echo
	echo -e "For further configuration options check:"
	echo -e "  /etc/7dtd.conf"
	echo
	echo -e "For feedback, suggestions, problems please visit the bugtracker:"
	echo -e "  https://7dtd.illy.bz/"
	echo
}

main() {
	intro
	nonDebianWarning

	if [ $ISDEBIAN -eq 1 ]; then
		installAptDeps
		if [ $INSTALLOPTIONALDEPS -eq 1 ]; then
#			installOptionalDeps
			echo
		fi
	else
		checkSetupDeps
	fi
	setupUser
	installManagementScripts
	setSteamLoginData
	installSteamCmdAndSDTD
	if [ $ADDCRONJOBS -eq 1 ]; then
		addCronJobs
	fi
	finish
}

if [ -z $1 ]; then
	showHelp
	exit 0
fi
while getopts "hcoip:u:g:" opt; do
	case "$opt" in
		h)
			showHelp
			exit 0
			;;
		c)
			ADDCRONJOBS=1
			;;
		o)
			INSTALLOPTIONALDEPS=1
			;;
		i)
			RUNINSTALL=1
			;;
		p)
			INSTALLDIR=$OPTARG/
			;;
		u)
			SDTD_USER=$OPTARG
			ADDUSER=0
			;;
		g)
			SDTD_GROUP=$OPTARG
			;;
	esac
done
if [ $RUNINSTALL -eq 1 ]; then
	main
fi
