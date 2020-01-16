#!/bin/bash

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
		echo "No internet connection, waiting 1 second" >>$LOG 2>&1
		sleep 1
	done

	echo "Found internet connection!" >>$LOG 2>&1
	echo "CLONING FROM GIT" >>$LOG 2>&1

	cd /opt/school
	git pull >>LOG 2>&1
	git submodule update --init --recursive >>$LOG 2>&1
	
	chmod -R 771 run_once >>$LOG 2>&1
	chmod -R 771 run_always >>$LOG 2>&1
	chmod -R 771 tools >>$LOG 2>&1

	update-rc.d update.sh defaults

	echo >>$LOG 2>&1

	version=$(cat run_once_version)
	for ((i=version + 1; ; ++i))
	do
		if [ -e run_once/$i.sh ]
		then
			echo "UPDATE NUMBER $i:" >>$LOG 2>&1
			run_once/$i.sh >>$LOG 2>&1
			echo $i > run_once_version
			echo >>$LOG 2>&1
		else
			break;
		fi
	done

	for file in run_always/*; do
		$file >>$LOG 2>&1
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
