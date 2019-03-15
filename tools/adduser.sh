#!/bin/zsh

username="$1"
if [ -z $username ]; then
	echo "Put username in arguments"
	exit 0
fi

useradd -d /home/$username -m -s $(which zsh) $username
for file in $(ls /home/guest-default/ -A); do
	cp /home/guest-default/$file /home/$username/ -rf
done
chown $username:$username /home/$username -R
passwd -d $username

