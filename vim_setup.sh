#!/usr/bin/env bash
#
# Setup file for Vim
#
# Created by Strex @ 3/26/18
#

# Check out our env

ver () {
    if [ -e "/etc/oracle-release" ]; then
        OS="Oracle Enterprise Linux"
        VERV=$(cut -d ' ' -f5 < /etc/oracle-release)
    elif [ -e "/etc/redhat-release" ]; then
        OS="RedHat Enterprise Linux"
        VERV=$(cut -d ' ' -f7 < /etc/redhat-release)
    elif [ -e "/etc/SuSE-release" ]; then
        OS="SUSE Linux Enterprise Server"
        VERV=$(grep VERSION_ID /etc/os-release |cut -d '"' -f2)
    elif [ -e "/etc/debian_version" ]; then
    	OS="Debian"
    	VERV=$(cat /etc/debian_version);
    elif [ "$(uname)" == "Darwin" ]; then
    	OS="Darwin"
    	VERV="Unknown"
    elif [ "$(uname)" == "MINGW64_NT" ] || [ "$(uname)" == "MINGW64_NT" ]; then
    	OS="Cygwin"
    	VERV="Unknown"
    fi

    # if [ -e "/bin/uname" ]; then
    #     VERR=$(uname -r |sed 's/.x86.*//g')
    # elif [ -e "/proc/version" ]; then
    #     VERR=$(cut -d ' ' -f3 < /proc/version)
    # fi

    printf "%s$OS\n$VERV ($VERV)\n"
}

# Vim Install function
vim-install () {
	if [ "$OS" == "Oracle Enterprise Linux" ]; then
		if [[ -n $(sudo -n true) ]]; then
			printf "Looks like we have sudo access..\\n"
			printf "Installing vim..\\n"
			yum install -y vim
		elif [[ -z $(sudo -n true) ]]; then
			printf "Sudo needs a password..\\n"
			printf "Attempting to install vim..\\n"
			sudo yum install -y vim
		fi
	elif [ "$OS" == "RedHat Enterprise Linux" ]; then
		if [[ -n $(sudo -n true) ]]; then
			printf "Looks like we have sudo access..\\n"
			printf "Installing vim..\\n"
			yum install -y vim
		elif [[ -z $(sudo -n true) ]]; then
			printf "Sudo needs a password..\\n"
			printf "Attempting to install vim..\\n"
			sudo yum install -y vim
		fi
	elif [ "$OS" == "SUSE Linux Enterprise Server" ]; then
		if [[ -n $(sudo -n true) ]]; then
			printf "Looks like we have sudo access..\\n"
			printf "Installing vim..\\n"
			zypper install -y vim
		elif [[ -z $(sudo -n true) ]]; then
			printf "Sudo needs a password..\\n"
			printf "Attempting to install vim..\\n"
			sudo zypper install -y vim
		fi
	elif [ "$OS" == "Debian" ]; then
		if [[ -n $(sudo -n true) ]]; then
			printf "Looks like we have sudo access..\\n"
			printf "Installing vim..\\n"
			apt-get install -y vim
		elif [[ -z $(sudo -n true) ]]; then
			printf "Sudo needs a password..\\n"
			printf "Attempting to install vim..\\n"
			sudo apt-get install -y vim
		fi
	elif [ "$OS" == "Darwin" ]; then
		if [[ -z $( command -v brew ) ]]; then
			if [[ -z $(sudo -n true) ]]; then
				printf "Looks like we have sudo access..\\n"
				printf "Installing vim..\\n"
				brew install vim
			elif [[ -n $(sudo -n true) ]]; then
				printf "Sudo needs a password..\\n"
				printf "Attempting to install vim..\\n"
				sudo brew install vim
			fi
		else
			printf "Looks like brew is not installed, please see: https://brew.sh/"
			exit 0
		fi
	elif [[ $OS == "Cygwin" ]]; then
		printf "Please re-run the Cygwin installer, and install vim.\\n"
		exit 0
	fi
}


if [ -n "$(command -v vim)" ]; then
	printf "Great, Vim's installed, proceeding\\n"
elif [ -z "$(command -v vim)" ]; then
	printf "Looks like Vim's not installed\\n"
	printf "Trying to install Vim\\n"
	ver
	vim-install
fi

if 	[[ -n "$( command -v vim)" ]]; then
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

		# Installing Hashpunk Theme
		printf "Installing Hashpunk theme\\n"
		curl -LSso ~/.vim/colors/hashpunk.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Colors/hashpunk.vim

		# Installing monit syntax highlighting
		printf "Installing Monit syntax highlighting\\n"
		curl -LSso ~/.vim/syntax/monitrc.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Syntax/monitrc.vim
		curl -LSso ~/.vim/ftdetect/monitrc.vim https://raw.githubusercontent.com/xstrex/BashSnips/master/Vim-Syntax/monitrc.ft

		# Done
		printf "Vim is installed and configured\\n"
		printf "Rad!\\n"

		exit 0
elif [[ -z "$( command -v vim)" ]]; then
	printf "Looks like something went wrong with the install, please install vim manually..\\n"
	exit 1
fi
