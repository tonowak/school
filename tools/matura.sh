#!/bin/zsh

username="Matura"

useradd -d /home/$username -m -s $(which zsh) $username
chown $username:$username /home/$username -R
echo "Matura:Matura" | chpasswd

cp /home/guest-default/.oh-my-zsh /home/matura/ -r
cp /home/guest-default/.bashrc /home/matura/ -r
cp /home/guest-default/.zshrc /home/matura/ -r
cp /home/guest-default/.profile /home/matura/ -r
apt install libreoffice-l10n-pl

