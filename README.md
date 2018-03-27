# BashSnips
Small collection of misc bash snippets, used for various scripts. 

Decent reference: https://devhints.io/bash

***

## Vim Setup Script
vim_setup.sh will check to see if you have vim installed, and try to install it if you don't.
Then create some needed vim directoris, download and install the pathogen plugin, and a few
color schemes. Finally it will install a .vimrc config file. 

### Installation
Simply run: `curl -s https://raw.githubusercontent.com/xstrex/BashSnips/master/vim_setup.sh | bash`

### Error checking
Currently there's very little error checking, if you find something, or would like to make an improvement
please issue a pull request, or open an issue. 

***

## Custom Bashrc
Adds a ton of aliases, and a few useful functions. 

### Installation
Simply run this: `curl -LSso .bashrc https://raw.githubusercontent.com/xstrex/BashSnips/master/bash.bashrc || source .bashrc`

### Current Functions
- cls : turn color "ls" on or off depending on OS
- als : list knowns aliases
- mcd : make and cd into directory
- tgz : create a tar.gz file from a file or dir
- ext : extract a ton of different formats

### Prompt
Sets a color bash prompt if the term supports color (otherwise a boring non-color prompt).
