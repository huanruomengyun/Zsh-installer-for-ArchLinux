#!/bin/bash
#-----------------------------------
# Author: Qingxu (huanruomengyun)
# Description: Zsh one-click installation cript for Arch Linux.
# Repository Address: https://github.com/huanruomengyun/Zsh-installer-for-ArchLinux
# Version: 0.1
# Copyright (c) 2020 Qingxu
#-----------------------------------
#Options
while getopts ":r" opt; do
	case $opt in
		r)
			sudo pacman -Rs zsh
			rm -rf ~/.oh-my-zsh ~/.hushlogin ~/.zshrc ~/.p10k.zsh
			chsh -s bash
			echo ""
			echo "Done. Restart session to take effect."
			exit
			;;
		\?)
			echo "Usage: runme.sh [-r]"
			exit
			;;
	esac
done
#Init
dir=$(cd "$(dirname "$0")"; pwd)
rc=~/.zshrc
touch ~/.hushlogin
#Zsh
sudo pacman -Syy
sudo pacman -S git zsh
sh -c "$(sed -e "/exec zsh -l/d" <<< $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
#Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" $rc
sed -i "s/plugins=(git)/plugins=(git extract web-search zsh-autosuggestions zsh-completions zsh-syntax-highlighting)/g" $rc
echo "Done. Restart session to take effect."