
mkdir openttd;
cd openttd;
wget http://binaries.openttd.org/releases/1.4.4/openttd-1.4.4-linux-generic-amd64.tar.gz;
tar -zxvf openttd-1.4.4-linux-generic-amd64.tar.gz;
mv openttd-1.4.4-linux-generic-amd64/* .;
rmdir openttd-1.4.4-linux-generic-amd64;
rm openttd-1.4.4-linux-generic-amd64.tar.gz;

cd baseset;
wget http://binaries.openttd.org/extra/opengfx/0.5.0/opengfx-0.5.0-all.zip;
unzip opengfx-0.5.0-all.zip;
tar -xvf opengfx-0.5.0.tar; 
rm opengfx-0.5.0-all.zip opengfx-0.5.0.tar;
mv opengfx-0.5.0 opengfx;

wget http://binaries.openttd.org/extra/opensfx/0.2.3/opensfx-0.2.3-all.zip;
unzip opensfx-0.2.3-all.zip;
rm opensfx-0.2.3-all.zip;
mv opensfx-0.2.3 opensfx;

wget http://binaries.openttd.org/extra/openmsx/0.3.1/openmsx-0.3.1-all.zip;
unzip openmsx-0.3.1-all.zip;
rm openmsx-0.3.1-all.zip;
mv openmsx-0.3.1 openmsx;

