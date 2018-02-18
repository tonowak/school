#!/bin/bash
version=0

echo Cloning updates from github
cd ../
rm -rf school
git clone https://github.com/tonowak/school > /dev/null
cd school
chmod -R 771 updates
echo

for ((i=version + 1; ; ++i))
do
	if [ -e updates/$i.sh ]
	then
		echo Update number $i:
		sh updates/$i.sh
		sed -i "2s/.*/version=$i/" update.sh
		echo
	else
		echo Made all updates, you can close the terminal
		exit 0
	fi
done
