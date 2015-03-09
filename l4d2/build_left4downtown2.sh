
apt-get -y install make g++ libc6-dev-i386 gcc-multilib;

ln -s /usr/include/asm-generic /usr/include/asm;

mkdir working;
cd working;

git clone https://github.com/Attano/Left4Downtown2.git left4downtown2;

mkdir addons;
mkdir addons/sourcemod;
mkdir addons/sourcemod/extensions;
mkdir addons/sourcemod/gamedata;
mkdir addons/sourcemod/scripting;
mkdir addons/sourcemod/scripting/include;


mkdir dt;
cd dt;

#git clone https://github.com/alliedmodders/sourcemod.git sourcemod-central;
#git clone https://github.com/alliedmodders/metamod-source mmsource-central;

#These should stay synced up with the versions installed by the addon.
git clone https://github.com/alliedmodders/sourcemod.git --branch 1.6-dev --single-branch sourcemod-central;
git clone https://github.com/alliedmodders/metamod-source --branch 1.10-dev --single-branch mmsource-central;
git clone https://github.com/alliedmodders/hl2sdk.git --branch l4d2 --single-branch hl2sdk-l4d2;

mkdir -p srcds/left4dead2/bin;
cp -R /home/ogpuser/OGP_User_Files/L4D2/bin/* srcds/left4dead2/bin/

cd ../left4downtown2;

make playerslots;

cd ../;

cp left4downtown2/Release/left4downtown.ext.2.l4d2.so addons/sourcemod/extensions;
cp left4downtown2/scripting/include/* addons/sourcemod/scripting/include;
cp left4downtown2/gamedata/left4downtown.l4d2.txt addons/sourcemod/gamedata;

tar -zcvf ../left4downtown2.tar.gz addons;
tar -zcvf ../src.tar.gz left4downtown2;
