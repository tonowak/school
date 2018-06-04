#!/bin/bash
version=0

echo "STARTING SCRIPT $(date)" >>/opt/school_log 2>&1

echo "WAITING FOR NETWORK"
while ! ping -c 5 google.com > /dev/null
do
	echo "No internet connection, waiting 5 seconds"
done

echo "Found internet connection!"
echo "CLONING FROM GIT"

cd /opt/
rm -rf school >>/opt/school_log 2>&1
git clone https://github.com/tonowak/school >>/opt/school_log 2>&1
cd /opt/school/
chmod -R 771 updates
echo

for ((i=version + 1; ; ++i))
do
	if [ -e updates/$i.sh ]
	then
		echo "UPDATE NUMBER $i:" >>/opt/school_log 2>&1
		updates/$i.sh >>/opt/school_log 2>&1
		sed -i "2s/.*/version=$i/" update.sh
		echo
	else
		break;
	fi
done

if ! diff -r /opt/school/guest-default /home/guest-default > /dev/null
then
	echo "COPYING GUEST" >>/opt/school_log 2>&1
	rm -r /home/guest-default/
	mkdir /home/guest-default/
	cp -r /opt/school/guest-default/ /home/
	chown guest-default /home/guest-default -R
fi

