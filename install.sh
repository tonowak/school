#!/bin/sh
apt-get -y update
apt-get -y install git

cd /opt/
rm -rf school/
git clone https://github.com/tonowak/school

ln -s /opt/school/update.sh /etc/init.d/update.sh
chmod 755 /etc/init.d/update.sh
update-rc.d update.sh defaults
