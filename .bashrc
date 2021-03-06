#!/usr/bin/env bash
#
# Bash.rc file for linux hosts
# Containing all common aliases
#
# If .bashrc is not included in .bash_profile,
# include the following in .bash_profile:
# if [ -f ~/.bashrc ]; then
#               . ~/.bashrc
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

# User settings

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to history don't overwrite it
shopt -s histappend

# History length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Check if our term supports color
if test -t 1; then

    ncolors=$(tput colors)

    if test -n "$ncolors" && test "$ncolors" -ge 8; then
        COLOR="true"
        bold="$(tput bold)"
        # underline="$(tput smul)"
        # standout="$(tput smso)"
        normal="$(tput sgr0)"
        # black="$(tput setaf 0)"
        red="$(tput setaf 1)"
        # green="$(tput setaf 2)"
        # yellow="$(tput setaf 3)"
        # blue="$(tput setaf 4)"
        # magenta="$(tput setaf 5)"
        # cyan="$(tput setaf 6)"
        white="$(tput setaf 7)"
    fi
fi

# Colorful man pages
if [ $COLOR == "true" ]; then
        export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
        export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
        export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
        export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
        export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
        export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
        export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan
fi

# Custom ls colors (defaults are too dark)
if [ $COLOR == "true" ]; then
        LS_COLORS='di=1;34:ex=1;31'
        export LS_COLORS
fi

if [ -n "$(which vim)" ]; then
    alias vi="vim"
else
    alias vi="vi"
fi

# For the lazy admin in all of us
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."

# Aliases for ls (based on os)
if [ "$OS" == "Darwin" ]; then
    alias ls="ls -CFG"
    alias la="ls -CFGA"
    alias ll="ls -1hFAlG"
    alias lll="ls -1hFAlG |less -r"
elif [ "$OS" == "Linux" ]; then
    alias ls="ls -CF --color=always"
    alias la="ls -CFA --color=always"
    alias ll="ls -1hFAl --color=always"
    alias lll="ls -1hFAl --color=always |less -r"
elif [ "$OS" == "Cygwin" ]; then
    alias ls="ls -CF --color=auto"
    alias la="ls -CFA --color=auto"
    alias ll="ls -1hFAl --color=auto"
    alias lll="ls -1hFAl --color=auto |less -r"
fi

# User specific aliases
alias c="clear"
alias cl="clear"
alias df="df -Tha"
alias du1="du -ach --max-depth=1"
alias free="free -mt"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias chx="chmod 755"
alias chr="chmod 644"
alias wget="wget -c"
alias hist="history | grep"
alias myip="curl http://ipecho.net/plain; echo"
alias lstz="tar -tf"

# Color dependent aliases

# Enable and disable color ls
cls () {
        if [ -z "$1" ]; then
                if [ $COLOR == "true" ]; then
                        echo "Enable and disable color ls | This terminal support color"
                else
                        echo "Enable and disable color ls | This terminal does not support color"
                        return 1
                fi
        elif [ "$1" == "on" ]; then
                if [ $COLOR == "true" ]; then
                        if [ $OS == "Darwin" ]; then
                          unalias ls && unalias la && unalias ll && unalias lll
                          alias ls="ls -CFG"
                          alias la="ls -CFGA"
                          alias ll="ls -1hFAlG"
                          alias lll="ls -1hFAlG |less -r"
                        else
                        unalias ls && unalias la && unalias ll && unalias lll
                        alias ls="ls -CF --color=auto"
                        alias la="ls -CFA --color=auto"
                        alias ll="ls -1hFAl --color=auto"
                        alias lll="ls -1hFAl --color=auto |less -r"
                        fi
                elif [ $COLOR == "false" ]; then
                        echo "This terminal does not support color"
                        return 1
                fi
        elif [ "$1" == "off" ]; then
                unalias ls && unalias la && unalias ll && unalias lll
                alias ls="ls -CF"
                alias la="ls -CFA"
                alias ll="ls -1hFAl"
                alias lll="ls -1hFAl"
        fi
}

# A few useful functions

# For when I forget
als () {
        echo "Known aliases:"
        grep ^alias .bashrc | cut -d ' ' -f 2- |sed 's/\"//;s/\=/ \= /;s/\"//;'
        echo
        if [ "$OS" == "Linux" ]; then
              echo "Known functions:"
              FUNCT="$(declare -F | cut -d ' ' -f 3 |grep -v ^_ |grep '^...$')"
              for i in $FUNCT; do
                    echo "$i:" "$($i)"
              done;
        else
              echo "Known functions:"
              echo "to be completed"
        fi
}

# Make and cd to new dir
mcd () {
 if [ -z "$1" ]; then
        echo "Make and change to new dir"
        return 1
 else
        mkdir -p "$1"
        cd "$1" || return
 fi
}

# Create .tar.gz
tgz () {
 if [ -z "$1" ]; then
        echo "tar & gz a file or directory"
        return 1
 else
        tar -zcvf "$1".tar.gz "$1"
        rm -r "$1"
 fi
}

# Extract file by type
ext () {
 if [ -z "$1" ]; then
    # display usage if no parameters given
        echo "Extract compressed file(s) ( zip | rar | bz2 | gz | tar | tbz2 | tgz | Z | 7z | xz | ex | tar.bz2 | tar.gz | tar.xz )"
    return 1
 else
    for n in "$@"
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
        PS1="\[${bold}\]\[${white}\][\[${red}\]\u\[${white}\]@\[${red}\]\h\[${white}\]]: \[${normal}\]"
        else
        PS1="[\u@\h]: "
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
