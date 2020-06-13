
# alaises
alias l='ls -l'
alias x='exit'

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH

# User specific functions
today() {
    echo -n "Today's date is: "
    date +"%A, %B %-d, %Y"
}
