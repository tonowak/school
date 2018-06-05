#!/bin/bash
version=0

echo "STARTING SCRIPT $(date)" >>/opt/school_log 2>&1

echo "WAITING FOR NETWORK" >>/opt/school_log 2>&1
while ! ping -c 5 google.com > /dev/null
do
	echo "No internet connection, waiting 5 seconds" >>/opt/school_log 2>&1
	sleep 5
done

echo "Found internet connection!" >>/opt/school_log 2>&1
echo "CLONING FROM GIT" >>/opt/school_log 2>&1

cd /opt/
rm -rf school >>/opt/school_log 2>&1
git clone https://github.com/tonowak/school >>/opt/school_log 2>&1
cd /opt/school/ >>/opt/school_log 2>&1
chmod -R 771 updates >>/opt/school_log 2>&1
echo >>/opt/school_log 2>&1

sed -i "2s/.*/version=$i/" update.sh >>/opt/school_log 2>&1
for ((i=version + 1; ; ++i))
do
	if [ -e updates/$i.sh ]
	then
		echo "UPDATE NUMBER $i:" >>/opt/school_log 2>&1
		updates/$i.sh >>/opt/school_log 2>&1
		sed -i "2s/.*/version=$i/" update.sh >>/opt/school_log 2>&1
		echo >>/opt/school_log 2>&1
	else
		break;
	fi
done

if ! diff -r /opt/school/guest-default /home/guest-default > /dev/null
then
	echo "COPYING GUEST" >>/opt/school_log 2>&1
	rm -r /home/guest-default/ >>/opt/school_log 2>&1
	mkdir /home/guest-default/ >>/opt/school_log 2>&1
	cp -r /opt/school/guest-default/ /home/ >>/opt/school_log 2>&1
	chown guest-default /home/guest-default -R >>/opt/school_log 2>&1
fi

echo "ENDED UPDATE AT $(date)" >>/opt/school_log 2>&1
