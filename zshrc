# ------------------------------------------------
# Aliases
# ------------------------------------------------

source "$HOME/dotfiles/aliases/aliases"

# ------------------------------------------------
# Basic PATH Setup
# ------------------------------------------------
# Prepend /usr/bin to prefer system binaries in some cases,
# and always include $HOME/bin for local user scripts.
export PATH="/usr/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# ------------------------------------------------
# Normalize PATH to remove accidental duplicates
# ------------------------------------------------
# Convert PATH to zsh array, make it unique, then re-join.
# This prevents the same directory appearing multiple times.
typeset -U path
path=(${(s/:/)PATH})      # split PATH on ':' into array named 'path'
PATH="${(j/:/)path}"      # join back into a colon-separated string

# ------------------------------------------------
# OS Detection (used to gate OS-specific blocks)
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
# If Homebrew is installed, evaluate its shellenv so brew-managed
# packages (like openjdk, bat, fd, etc.) appear on PATH.
if [[ "$OS_TYPE" == "macos" ]]; then
  # Typical ARM mac path; Intel macs may have /usr/local as well.
  if [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
elif [[ "$OS_TYPE" == "linux" ]]; then
  # Linuxbrew (optional) location
  if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# If you want Homebrew's recommended persistent change for macOS:
# Add these lines to ~/.zprofile (run once):
#   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
# The eval above is enough for the current shell; adding to zprofile
# ensures it applies to login shells (recommended on macOS).

# ------------------------------------------------
# Go (GOPATH / go bin)
# ------------------------------------------------
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin"

# ------------------------------------------------
# Pyenv (Python version manager)
# ------------------------------------------------
# Only set up pyenv if it's installed.
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"

  # On macOS, pyenv's recommended initialization for modern setups:
  if [[ "$OS_TYPE" == "macos" ]]; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  else
    # Linux: include virtualenv integration if available
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
  fi
fi

# ------------------------------------------------
# Android / Java (React Native dev)
# ------------------------------------------------
# Set ANDROID_HOME conditionally per OS (macOS vs Linux)
if [[ "$OS_TYPE" == "linux" ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
else
  export ANDROID_HOME="$HOME/Library/Android/sdk"
fi

# Add Android SDK tools and platform-tools to PATH
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# If you install Java via Homebrew on macOS, you may want to set JAVA_HOME.
# Example (replace path/version as needed):
if [[ "$OS_TYPE" == "macos" ]]; then
  export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home"
fi

# ------------------------------------------------
# Ruby Gems
# ------------------------------------------------
# Keep gem binaries in user's PATH (avoid interfering with system gems)
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
# Add google-cloud-sdk bin and, if present, source its helper scripts.
export PATH="$PATH:$HOME/google-cloud-sdk/bin"

# Update PATH for gcloud if the helper exists (this also sets up Python envs)
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && . "$HOME/google-cloud-sdk/path.zsh.inc"
# Enable gcloud command completion if available
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && . "$HOME/google-cloud-sdk/completion.zsh.inc"

# ------------------------------------------------
# Ansible / Local Python user installs
# ------------------------------------------------
export PATH="$PATH:$HOME/.local/bin"

# ------------------------------------------------
# Zsh History & Directory Navigation
# ------------------------------------------------
# Prevent duplicate history lines, enable pushd stack features, and silence pushd output.
setopt HIST_SAVE_NO_DUPS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

alias d='dirs -v'        # show directory stack with indexes

# Create aliases 1..9 to jump to numbered entries on the pushd stack
# Example: '2' jumps to the 2nd entry on the dirs list.
for index in {1..9}; do
  alias "$index"="cd +${index}"
done
unset index

# NOTE:
# Every directory visited will populate the stack. Using 'd' lists them:
#   d
# Then run e.g. '3' to jump to the 3rd directory on the stack.

# ------------------------------------------------
# Keybindings & Vim Mode
# ------------------------------------------------
bindkey -v               # enter vi keybindings in the shell
export KEYTIMEOUT=1      # reduce key chord delay for vi-mode

# Cursor Mode (loads a small prompt/visual helper from our dotfiles)
fpath=($HOME/dotfiles/config_zsh $fpath)
autoload -Uz cursor_mode; cursor_mode

# Custom prompt loader (autoloaded from our dotfiles)
autoload -Uz myprompt; myprompt

# ------------------------------------------------
# Git Completion
# ------------------------------------------------
# Use our custom git completions file and ensure the fpath contains it
zstyle ':completion:*:*:git:' script "$HOME/dotfiles/completions/git/git-completion.bash"
fpath=($HOME/dotfiles/completions/git $fpath)

autoload -Uz compinit && compinit

# ------------------------------------------------
# LS_COLORS tweaks
# ------------------------------------------------
# Make 'ow' (others writable) and 'tw' (sticky + world writeable) directories show clearly.
export LS_COLORS="${LS_COLORS:-}:ow=1;34;45:tw=1;34:"

# ------------------------------------------------
# NVM (Node Version Manager)
# ------------------------------------------------
export NVM_DIR="$HOME/.nvm"
# Load nvm and its bash completion if present
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ------------------------------------------------
# User Functions
# ------------------------------------------------
today() {
  # Prints a friendly current date
  echo -n "Today's date is: "
  date +"%A, %B %-d, %Y"
}

weather() {
  # Quick wttr.in lookup. Usage: weather or weather <city>
  local city=$1
  if [ -z "$city" ]; then
    curl --silent --show-error wttr.in/Karachi
  else
    curl --silent --show-error "wttr.in/${city}"
  fi
}

# Easily open deep links in iOS / Android emulators.
# ios_open requires Xcode command line tools; android_open requires adb in $ANDROID_HOME/platform-tools
ios_open()    { xcrun simctl openurl booted "$@" }
android_open(){ "$ANDROID_HOME/platform-tools/adb" shell am start -W -a android.intent.action.VIEW -d "$@" 2>/dev/null || true }

# ------------------------------------------------
# kubectl completion
# ------------------------------------------------
# Source kubectl completion only when kubectl exists to avoid errors.
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# ------------------------------------------------
# fzf (fuzzy finder)
# ------------------------------------------------
# Source fzf if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf appearance + behavior options
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

export FZF_TMUX_OPTS=' -p 80%'  # Note: this may need tweaking for our tmux layout
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# TODO: when setup ripgrep
# export FZF_DEFAULT_COMMAND='rg --color always --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# ------------------------------------------------
# pnpm (package manager)
# ------------------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;   # already present
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
