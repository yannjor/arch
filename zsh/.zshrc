# Exports
export ZSH="/home/yann/.oh-my-zsh"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.bin"

# Plugins
plugins=(fast-syntax-highlighting zsh-autosuggestions tmux)

# tmux
ZSH_TMUX_AUTOSTART=true

# Spaceship config
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PROMPT_SEPARATE_LINE="false"

source $ZSH/oh-my-zsh.sh

# ALIASES
alias cat="bat"
alias ls="exa"
alias gs="git status"
alias gl="git log"
alias gc="git clone"
alias gp="git push"
alias gd="git diff"
alias ga="git add -A"
alias vim="nvim"
alias vi="nvim"
alias cl="clear"

# Display random pokemon :)
pokemon-colorscripts -r 1-4
