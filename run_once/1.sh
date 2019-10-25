#!/bin/sh

inst() {
	for i in "$@"
	do
		apt-get -y install $i >>/opt/school_log 2>&1
	done
}

apt-get -y update
apt-get -y upgrade

inst clang g++-multilib
inst vim kate kwrite gedit emacs scite vim-gnome codeblocks geany

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get -y install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt-get -y update
inst sublime-text

inst valgrind kcachegrind gdb

inst git ipython arduino
