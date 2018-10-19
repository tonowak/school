#!/bin/bash
version=0

### BEGIN INIT INFO
# Provides:          school_update
# Required-Start:    networking
# Required-Stop:     
# Default-Start:     4
# Default-Stop:      
# Short-Description: school update script
# Description:       Script used to update
#                    school's Linux Mints
#                    by Tomasz Nowak
#                    13 LO Szczecin
### END INIT INFO

start() {
	LOG="/opt/school_log"

	echo "STARTING SCRIPT $(date)" >>$LOG 2>&1

	echo "WAITING FOR NETWORK" >>$LOG 2>&1
	while ! ping -c 5 google.com > /dev/null
	do
		echo "No internet connection, waiting 5 seconds" >>$LOG 2>&1
		sleep 5
	done

	echo "Found internet connection!" >>$LOG 2>&1
	echo "CLONING FROM GIT" >>$LOG 2>&1

	cd /opt/
	rm -rf school >>$LOG 2>&1
	git clone https://github.com/tonowak/school >>$LOG 2>&1
	cd /opt/school/ >>$LOG 2>&1
	chmod -R 771 updates >>$LOG 2>&1
	update-rc.d update.sh defaults
	echo >>$LOG 2>&1

	sed -i "2s/.*/version=$version/" update.sh >>$LOG 2>&1
	for ((i=version + 1; ; ++i))
	do
		if [ -e updates/$i.sh ]
		then
			echo "UPDATE NUMBER $i:" >>$LOG 2>&1
			updates/$i.sh >>$LOG 2>&1
			sed -i "2s/.*/version=$i/" update.sh >>$LOG 2>&1
			echo >>$LOG 2>&1
		else
			break;
		fi
	done

	if ! diff -r /opt/school/guest-default /home/guest-default > /dev/null
	then
		echo "COPYING GUEST" >>$LOG 2>&1
		rm -r /home/guest-default/ >>$LOG 2>&1
		mkdir /home/guest-default/ >>$LOG 2>&1
		cp -r /opt/school/guest-default/ /home/ >>$LOG 2>&1
		chown guest-default /home/guest-default -R >>$LOG 2>&1
		chmod +x -R /home/guest-default
	fi

	echo "ENDED UPDATE AT $(date)" >>$LOG 2>&1
}

case "$1" in
  start)
    start
    ;;
  *)
	  echo "Usage: update.sh start"
esac
