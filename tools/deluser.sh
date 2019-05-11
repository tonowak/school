#!/bin/zsh

username="$1"
if [ -z $username ]; then
	echo "Put username in arguments"
	exit 0
fi

deluser --remove-home "$username"
