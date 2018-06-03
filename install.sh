#!/bin/sh
apt-get -y update
apt-get -y install git

cd /opt/
# rm -rf school/
# git clone https://github.com/tonowak/school

ln -s /opt/school/update.sh /etc/init.d/update.sh
chmod 755 /etc/init.d/update.sh
ln -s /etc/init.d/update.sh /etc/rc5.d/S99update.sh

