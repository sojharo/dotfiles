# alaises
source $HOME/dotfiles/aliases/aliases

# User specific environment and startup programs
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/bin
export DOCKER_HOST=/usr/bin/docker

setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt AUTO_PUSHD                # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# What does the above do?
#
# Every directory visited will populate the stack.
# When you use the alias d, it will display the directories on the stack prefixed with a number.
# The line for index ({1..9}) alias "$index"="cd +${index}"; unset index will create aliases from 1 to 9. They will allow you to jump directly in whatever directory on your stack.

# Setting vim mode
bindkey -v
export KEYTIMEOUT=1

# Cursor Mode (like vim)
fpath=($HOME/dotfiles/config_zsh $fpath)
autoload -Uz cursor_mode; cursor_mode

# For prompt
autoload -Uz myprompt; myprompt

# Git completions added
zstyle ':completion:*:*:git:' script /Users/sojharo/dotfiles/completions/git/git-completion.bash
fpath=($HOME/dotfiles/completions/git $fpath)

autoload -Uz compinit && compinit

# zmodload -i zsh/complist
# zstyle ':completion:*' menu select
# autoload predict-on
# predict-on

# For setting up NVM Node Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# User specific functions
today() {
    echo -n "Today's date is: "
    date +"%A, %B %-d, %Y"
}

weather() {
  city=$1
  if [ -z "$city" ]
  then
    curl wttr.in/Karachi
  else
    curl wttr.in/$city
  fi
}
