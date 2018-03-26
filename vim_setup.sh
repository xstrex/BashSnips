#!/usr/bin/env bash
#
# Setup file for Vim
#
# Created by Strex @ 3/26/18
#
# mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim=$(which vim)
sudo=$(which sudo)
curl=$(which curl)

if [ -n "$vim" ]; then
	printf "Great, Vim's installed, proceeding..\\n"
elif [[ -z $vim ]]; then
	printf "Looks like Vim's not installed..\\n"
	printf "Trying to install Vim\\n"
	vim-install
fi

# Check our env
if [ "$(uname)" == "Darwin" ]; then
        OS="Darwin"
elif [ "$(uname)" == "Linux" ]; then
        OS="Linux"
elif [ "$(uname)" == "MINGW32_NT" ]; then
        OS="Cygwin"
elif [ "$(uname)" == "MINGW64_NT" ]; then
        OS="Cygwin"
fi

# Vim Install function
vim-install () {
	if [ -n "$sudo" ]; then
		if [[ -z $($sudo -n true) ]]; then
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

# Make vim directories
printf "Setting up directories.."
eval mkdir -p ~/.vim/autoload ~/.vim/bundle 


	#statements