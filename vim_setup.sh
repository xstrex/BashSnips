#!/usr/bin/env bash
#
# Setup file for Vim
#
# Created by Strex @ 3/26/18
#

# Check our env
if [ "$(uname)" == "Darwin" ]; then
        OS="Darwin"
elif [ "$(uname)" == "Linux" ]; then
        OS="Linux"
elif [ "$(uname)" == "MINGW64_NT" ] || [ "$(uname)" == "MINGW64_NT" ]; then
        OS="Cygwin"
fi

# Vim Install function
vim-install () {
	if [ -n "$(sudo)" ]; then
		if [[ -z $(sudo -n true) ]]; then
			printf "Looks like we have sudo access..\\n"
			printf "Installing vim..\\n"
			if [ $OS == "Darwin" ]; then
				eval brew install vim
			elif [ $OS == "Linux" ]; then
				eval apt-get -y install vim
			elif [ $OS == "Cygwin" ]; then
				printf "Please re-run the Cygwin installer, and install vim.\\n"
				exit 0
			fi
		else
			printf "Sudo needs a password\\n"
			printf "Please install vim then re-run \$0\\n"
			exit 0
		fi
	else
		printf "Sudo is not installed\\n"
		printf "Please intall vim manually, then re-run \$0\\n"
		exit 0
	fi
}

if [ -n "$(command -v vim)" ]; then
	printf "Great, Vim's installed, proceeding\\n"
elif [ -z "$(command -v vim)" ]; then
	printf "Looks like Vim's not installed\\n"
	printf "Trying to install Vim\\n"
	vim-install
fi

# Make vim directories
printf "Setting up directories\\n"
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/syntax ~/.vim/colors ~/.vim/ftdetect

# Installing custom vimrc file
printf "Setting up custom vimrc file\\n"
curl -LSso ~/.vim/vimrc https://raw.githubusercontent.com/xstrex/BashSnips/master/vim.rc

# Setting up pathogen
printf "Setting up pathogen.vim\\n"
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Installing Solarized Theme
printf "Installing distinguished theme\\n"
curl -LSso ~/.vim/colors/distinguished.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Colors/distinguished.vim

# Installing Vividchalk Theme
printf "Installing Vividchalk theme\\n"
curl -LSso ~/.vim/colors/vividchalk.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Colors/vividchalk.vim

# Installing monit syntax highlighting
printf "Installing Monit syntax highlighting\\n"
curl -LSso ~/.vim/syntax/monitrc.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Syntax/monitrc.vim
curl -LSso ~/.vim/ftdetect/monitrc.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Syntax/monitrc.ft

# Done
printf "Vim is installed and configured\\n"
printf "Rad!\\n"

exit 0
