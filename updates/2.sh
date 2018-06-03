#!/bin/sh

mkdir /home/guest-default
useradd -d /home/guest-default -s /bin/bash guest-default
chown guest-default /home/guest-default
chmod 0750 /home/guest_default

# hide user
cat << EOF > /var/lib/AccountsService/users/guest-default
[User]
SystemAccount=true
EOF

# link to guests
mkdir /etc/guest-session
ln -s /home/guest-default /etc/guest-session/skel

