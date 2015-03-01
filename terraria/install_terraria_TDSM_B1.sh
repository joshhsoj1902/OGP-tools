#This should be executed in the home folder/be used to base the rsync off of 
#svn checkout https://github.com/DeathCradle/Terraria-s-Dedicated-Server-Mod.git/trunk/Official;
#mv Official/* .;
#rm -rf Official;
wget https://github.com/DeathCradle/Terraria-s-Dedicated-Server-Mod/releases/download/beta-1/tdsm-rebind-b1.zip;
A | unzip tdsm-rebind-b1.zip;
rm tdsm-rebind-b1.zip;
n | mono tdsm-patcher.exe;
