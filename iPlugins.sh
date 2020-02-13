#!/bin/bash

#I know it looks scary but I only define colors this way ;)
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

printf "${blu}Welcome to the plugin install script${end}\nWe are now going to install ${grn}oh-my-zsh${end} and ${grn}zsh-syntax-highlighting${end} to your machine\n \nWhere do you want the plugins to be installed? (absolute paths please, I dont like relatives :D)\n"
configsDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
read dir
printf "I am installing to $dir\n"
if [[ -e $dir ]]; then
	printf "Everything looking ok\n"
else
	prevDir=$(echo $dir | rev | cut -d '/' -f 2- | rev)
	if [[ -w $prevDir ]]; then
		printf "Folder does not exist, creating\n";
		mkdir $dir
	else
		printf "${red}Error: No permissions to write or too many subfolders to create\n${end}"
		exit 1
	fi
fi
cd $dir
printf "${grn}Everything looking good, well done.${end}\nNow installing plugins\n"
git clone https://github.com/ohmyzsh/ohmyzsh.git oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

printf "${grn}Repos cloned successfully!\n${end}"
cp $configsDir/konno-yuuki.zsh-theme $dir/oh-my-zsh/themes/
printf "${grn}Default Theme successfully installed\n${end}"

printf "${grn}Done!!${end} Next steps:\n1.Copy the .zshrc according to your OS to ~/ (your home directory).\n2.Launch Zsh (type zsh, press ENTER)\n${blu}Thanks for installing using my install script!!${end}"
