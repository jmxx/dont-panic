#!/usr/bin/env bash

# We move to HOME folder
cd ~

# Update and upgrade system
sudo apt-get update
sudo apt-get upgrade

sudo add-apt-repository -y ppa:videolan/stable-daily
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager

echo 'deb http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
echo 'deb-src http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc | sudo apt-key add -

# Update and upgrade system again
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

sudo apt-get install synaptic vlc y-ppa-manager bleachbit openjdk-7-jre oracle-java8-installer flashplugin-installer unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras ubuntu-wallpapers*

# Install essential packages
sudo apt-get install zsh git git-core git-extras build-essential wget curl python-software-properties virtualbox

# Configure zsh as defautl shell
echo "Changing shell to zsh"
chsh -s `which zsh`

# Install Oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh#basic-installation
echo "Installing Oh-my-zsh"
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# Install NVM
# https://github.com/creationix/nvm#install-script
echo "Installing NVM"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | sh

# We install Google Chrome
echo "Installing Google Chrome"
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

cd ~

echo "Cleaning Up" &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean

echo "Done!"
