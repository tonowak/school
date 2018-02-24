#!/bin/bash
echo Description: Instalowanie edytorów tekstu, rzeczy do kodzenia

inst() {
	for i in "$@"
	do
		echo $i
		apt-get -y install $i > /dev/null
	done
}


echo Aktualizacja systemu
apt-get -y update > /dev/null
apt-get -y upgrade > /dev/null


echo Instalacja kompilatorów
inst clang g++-multilib


echo Instalacja konsolowych edytorów tekstu
inst vim mc


echo Instalacja graficznych edytorów tekstu
inst kate kwrite gedit emacs scite

echo gvim
apt-get -y install vim-gnome > /dev/null

echo sublime-text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get -y install apt-transport-https > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt-get -y update > /dev/null
apt-get -y install sublime-text > /dev/null


echo Instalacja środowisk programistycznych
inst codeblocks geany


echo Instalacja narzędzi do debuggowania
inst valgrind
apt-get -y install kachegrind > /dev/null
echo gprof
echo gdb


echo Instalacja reszty
inst ipython
