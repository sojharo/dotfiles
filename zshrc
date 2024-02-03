# alaises
source $HOME/dotfiles/aliases/aliases

# TODO Organize these paths
export PATH="/usr/bin:$PATH"

# User specific environment and startup programs
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Setting up pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# For linux setup
# NOTE: above and this should be in if and else blocks based on OS
#   # https://www.tecmint.com/pyenv-install-and-manage-multiple-python-versions-in-linux/
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"

# Setting up React Native
# https://reactnative.dev/docs/environment-setup
# export ANDROID_HOME="$HOME/Android/Sdk" # This is for linux, it should be in if and else blocks later
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.14.1+1/Contents/Home"

export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$GEM_HOME/ruby/2.6.0/bin:$PATH"

export DENO_INSTALL="/Users/sojharomangi/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/bin"
# export DOCKER_HOST="unix:///run/user/1000/docker.sock"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Setting up gcloud cli for k9s
export PATH="$PATH:$HOME/google-cloud-sdk/bin"

# Ansible path
export PATH="$PATH:$HOME/.local/bin"

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

# for syntax highlighting of gnome-terminal for files will full permissions
export LS_COLORS="$LS_COLORS:ow=1;34;45:tw=1;34:"

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

# Easily open deep links in your iOS/Android emulator
ios_open() { xcrun simctl openurl booted "$@" }
android_open() { $ANDROID_HOME/platform-tools/adb shell am start -W -a android.intent.action.VIEW -d "$@" }

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# Following is completion for kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# fzf keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf settings
export FZF_DEFAULT_OPTS="
  --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672
  --height 60% --layout=reverse --border --margin=1 --padding=1
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down,3,wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' "$@" ;;
  esac
}

export FZF_TMUX_OPTS=' -p 80%'  # This does not work, need to investigate, I have alias now for fzf-tmux to open in popup

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# TODO: when setup ripgrep
# export FZF_DEFAULT_COMMAND='rg --color always --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

