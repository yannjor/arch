# Exports
export ZSH="/home/yann/.oh-my-zsh"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.bin"

# Plugins
plugins=(fast-syntax-highlighting zsh-autosuggestions)

# Spaceship config
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PROMPT_SEPARATE_LINE="false"

source $ZSH/oh-my-zsh.sh

# ALIASES
alias cat="bat"
alias ls="exa"
alias gs="git status"
alias gc="git clone"
alias vim="nvim"
alias cl="clear"
