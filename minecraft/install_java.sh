#!/bin/bash
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list

#TODO: Test if this will acutally cause the java install to not prompt
#echo debconf shared/accepted-oracle-license-v1-1 select true | \
#  sudo debconf-set-selections
#echo debconf shared/accepted-oracle-license-v1-1 seen true | \
#  sudo debconf-set-selections

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get -y install oracle-java8-installer libxtst6
exit
