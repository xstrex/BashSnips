# Bash.bashrc
#
# Bash.rc file for linux hosts
# Containing all common aliases
# 
# If .bashrc is not included in .bash_profile,
# include the following in .bash_profile:
# if [ -f ~/.bashrc ]; then
# 		. ~/.bashrc
# fi
# 
# Command alias candidates
# history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
#
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Source global system definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# For the lazy admin in all of us
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."

# User specific aliases
alias cl="clear"
alias ls="ls -CF"
alias lsl="ls -1hFAl |less"
alias df="df -Tha"
alias du1="du -ach --max-depth=1"
alias free="free -mt"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias wget="wget -c"
alias hist="history | grep"
alias myip="curl http://ipecho.net/plain; echo"

# Check if our term supports color
if test -t 1; then

    ncolors=$(tput colors)

    if test -n "$ncolors" && test $ncolors -ge 8; then
		COLOR="true"
        bold="$(tput bold)"
        underline="$(tput smul)"
        standout="$(tput smso)"
        normal="$(tput sgr0)"
        black="$(tput setaf 0)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
        yellow="$(tput setaf 3)"
        blue="$(tput setaf 4)"
        magenta="$(tput setaf 5)"
        cyan="$(tput setaf 6)"
        white="$(tput setaf 7)"
    fi
fi

# A few useful functions

# For when I forget
als () {
	echo "Known aliases:"
	grep '^alias ' ~/.bashrc
}

# Make and cd to new dir
mcd () {
	mkdir -p $1
	cd $1
}

# Extract file by type
extract () {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Custom bash prompt
if [ $COLOR == "true" ]; then
	export PS1="${bold}${white}[${red}\u${white}@${red}\h${white}]: ${normal}"
	else
	export PS1="[\u@\h]: "
fi
