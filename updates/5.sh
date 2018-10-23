# installing zsh

sudo apt-get update
sudo apt-get install zsh -y
mkdir /home/guest-default/.oh-my-zsh/
export ZSH="/home/guest-default/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/^DSHELL=.*/DSHELL=\/bin\/zsh/g' /etc/adduser.conf
