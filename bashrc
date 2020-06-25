
# alaises
alias l='ls -l'
alias x='exit'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'
alias cd..='cd ..'
alias ck='cd ~/RestructureWork'
alias ns='npm start'
alias nr='npm run'
alias gpm='git pull origin master'
alias gps='git pull origin staging'

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH

# User specific functions
today() {
    echo -n "Today's date is: "
    date +"%A, %B %-d, %Y"
}
