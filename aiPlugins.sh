#!/bin/bash

configsDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
dir="/opt/zsh-plugins"
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
