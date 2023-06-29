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
git clone https://github.com/zsh-users/zsh-autosuggestions.git oh-my-zsh/plugins/zsh-autosuggestions

printf "${grn}Repos cloned successfully!\n${end}"
printf "Do you want to install and enable the konno-yuuki theme? (Type y to accept)\n"
read answer
if [[ $answer == "y" ]]; then
	cp $configsDir/konno-yuuki.zsh-theme $dir/oh-my-zsh/themes/
	printf "${grn}Konno Yuuki Theme successfully installed\n${end}"
	rccontent="ZSH_THEME=\"konno-yuuki\"\nplugins=(\n\tgit\n\tzsh-autosuggestions\n)\nsource $dir/oh-my-zsh/oh-my-zsh.sh\nsource $dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n"

else
	printf "Skipping theme\n"
	rccontent="ZSH_THEME=\"gentoo\"\nplugins=(git zsh-autosuggestions)\nsource $dir/oh-my-zsh/oh-my-zsh.sh\nsource $dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n"
fi

# checks if a .zshrc file already exists in the home directory
if [[ -e ~/.zshrc ]]; then
	printf "${blu}A .zshrc file already exists in your home directory. Do you want to overwrite it? (Type y to accept)${end}\n"
	read answer
	if [[ $answer == "y" ]]; then
		printf $rccontent > $HOME/.zshrc
		printf "${grn}Successfully created .zshrc in home directory\n${end}"
	else
		printf "Skipping .zshrc\n"
		printf "It might be necessary to append the following in your configuration: \n"
		printf "$rccontent"
	fi
else
	printf "$rccontent" > $HOME/.zshrc
	printf "${grn}Successfully created .zshrc in home directory\n${end}"
fi


printf "${grn}Done!!${end}\nThanks for installing using my install script!!"
