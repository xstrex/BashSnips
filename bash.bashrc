# Bash.bashrc
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
elif [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
        OS="Linux"
elif [ "$(expr substr "$(uname -s)" 1 10)" == "MINGW32_NT" ]; then
        OS="Cygwin"
elif [ "$(expr substr "$(uname -s)" 1 10)" == "MINGW64_NT" ]; then
        OS="Cygwin"
fi

# User settings
# Do you want the LS listing to be in color?
COLORLS="false"

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
fi

# For the lazy admin in all of us
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."

# User specific aliases
alias c="clear"
alias ls="ls -CF"
alias ll="ls -1hFAl"
alias lll="ls -1hFAl"
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
alias uptime="uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g'"

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
                        unalias ls && unalias ll && unalias lll
                        alias ls="ls -CF --color=auto"
                        alias ll="ls -1hFAl --color=auto"
                        alias lll="ls -1hFAl --color=auto |less -r"
                elif [ $COLOR == "false" ]; then
                        echo "This terminal does not support color"
                        return 1
                fi
        elif [ "$1" == "off" ]; then
                unalias ls && unalias ll && unalias lll
                alias ls="ls -CF"
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
        echo "Known functions:"
        FUNCT=$(declare -F |cut -d ' ' -f 3 |grep -v als)
        for i in $FUNCT; do
                echo "$i:" $($i)
        done;
}

# Make and cd to new dir
mcd () {
 if [ -z "$1" ]; then
        echo "Make and change to new dir"
        return 1
 else
        mkdir -p $1
        cd $1
 fi
}

# Create .tar.gz
tgz () {
 if [ -z "$1" ]; then
        echo "tar & gz a file or directory"
        return 1
 else
        tar -zcvf $1.tar.gz $1
        rm -r $1
 fi
}

# Extract file by type
extract () {
 if [ -z "$1" ]; then
    # display usage if no parameters given
        echo "Extract compressed file(s) ( zip | rar | bz2 | gz | tar | tbz2 | tgz | Z | 7z | xz | ex | tar.bz2 | tar.gz | tar.xz )"
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
        export PS1="\[${bold}\]\[${white}\][\[${red}\]\u\[${white}\]@\[${red}\]\h\[${white}\]]: \[${normal}\]"
        else
        export PS1="[\u@\h]: "
fi
