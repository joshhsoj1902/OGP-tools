#Maybe MONO should be installed on my servers by default?
#
#To install the latest version see here:
#http://www.mono-project.com/docs/getting-started/install/linux/#debian-ubuntu-and-derivatives

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF;
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list;
sudo apt-get update;

sudo apt-get -y install mono-complete;
sudo apt-get -y install mono-runtime;
sudo apt-get -y install libmono-system-core4.0-cil
