# ------------------------------------------------
# Aliases
# ------------------------------------------------
source "$HOME/dotfiles/aliases/aliases"

# ------------------------------------------------
# Basic PATH Setup
# ------------------------------------------------
export PATH="/usr/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# ------------------------------------------------
# OS Detection
# ------------------------------------------------
uname_str="$(uname -s)"
case "$uname_str" in
  Linux*)   OS_TYPE="linux" ;;
  Darwin*)  OS_TYPE="macos" ;;
  *)        OS_TYPE="unknown" ;;
esac

# ------------------------------------------------
# Homebrew Setup (macOS + optional Linuxbrew)
# ------------------------------------------------
if [[ "$OS_TYPE" == "macos" ]]; then
  # Homebrew (ARM Macs default path)
  if [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
elif [[ "$OS_TYPE" == "linux" ]]; then
  if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# ------------------------------------------------
# Go Setup
# ------------------------------------------------
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin"

# ------------------------------------------------
# Pyenv Setup
# ------------------------------------------------
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"

  if [[ "$OS_TYPE" == "macos" ]]; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  else
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# ------------------------------------------------
# Android / Java Setup
# ------------------------------------------------
if [[ "$OS_TYPE" == "linux" ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
else
  export ANDROID_HOME="$HOME/Library/Android/sdk"
fi
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Java (macOS Homebrew path)
if [[ "$OS_TYPE" == "macos" ]]; then
  export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home"
fi

# ------------------------------------------------
# Ruby Gems
# ------------------------------------------------
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$GEM_HOME/ruby/2.6.0/bin:$PATH"

# ------------------------------------------------
# Deno
# ------------------------------------------------
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ------------------------------------------------
# Google Cloud SDK
# ------------------------------------------------
export PATH="$PATH:$HOME/google-cloud-sdk/bin"

# The next line updates PATH for the Google Cloud SDK.
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && ". $HOME/google-cloud-sdk/path.zsh.inc"
# The next line enables shell command completion for gcloud.
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && ". $HOME/google-cloud-sdk/completion.zsh.inc"

# ------------------------------------------------
# Ansible
# ------------------------------------------------
export PATH="$PATH:$HOME/.local/bin"

# ------------------------------------------------
# Zsh History & Directory Navigation
# ------------------------------------------------
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt AUTO_PUSHD                # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}); do alias "$index"="cd +${index}"; done; unset index

# What does the above do?
#
# Every directory visited will populate the stack.
# When you use the alias d, it will display the directories on the stack prefixed with a number.
# The line for index ({1..9}) alias "$index"="cd +${index}"; unset index will create aliases from 1 to 9. They will allow you to jump directly in whatever directory on your stack.

# ------------------------------------------------
# Keybindings & Vim Mode
# ------------------------------------------------
bindkey -v
export KEYTIMEOUT=1

# Cursor Mode (like vim)
fpath=($HOME/dotfiles/config_zsh $fpath)
autoload -Uz cursor_mode; cursor_mode

# Prompt
autoload -Uz myprompt; myprompt

# ------------------------------------------------
# Git Completion
# ------------------------------------------------
zstyle ':completion:*:*:git:' script "$HOME/dotfiles/completions/git/git-completion.bash"
fpath=($HOME/dotfiles/completions/git $fpath)
autoload -Uz compinit && compinit

# ------------------------------------------------
# LS Colors
# ------------------------------------------------
export LS_COLORS="$LS_COLORS:ow=1;34;45:tw=1;34:"

# ------------------------------------------------
# NVM
# ------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------------------------------------------
# User Functions
# ------------------------------------------------
today() {
  echo -n "Today's date is: "
  date +"%A, %B %-d, %Y"
}

weather() {
  local city=$1
  if [ -z "$city" ]; then
    curl wttr.in/Karachi
  else
    curl wttr.in/$city
  fi
}

# Easily open deep links in your iOS/Android emulator
ios_open() { xcrun simctl openurl booted "$@" }
android_open() { "$ANDROID_HOME/platform-tools/adb" shell am start -W -a android.intent.action.VIEW -d "$@" }

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# ------------------------------------------------
# FZF
# ------------------------------------------------
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
    cd)           fzf --preview 'tree -C {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \\$'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' "$@" ;;
  esac
}

export FZF_TMUX_OPTS=' -p 80%'  # (check again) This does not work, need to investigate, I have alias now for fzf-tmux to open in popup
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# TODO: when setup ripgrep
# export FZF_DEFAULT_COMMAND='rg --color always --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

# ------------------------------------------------
# pnpm
# ------------------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
