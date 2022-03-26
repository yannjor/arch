# Plugins
plugins=(fast-syntax-highlighting zsh-autosuggestions tmux)

# tmux
# ZSH_TMUX_AUTOSTART=true

# Spaceship config
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  rust          # Rust section
  venv          # virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_USER_SHOW="always"
SPACESHIP_USER_PREFIX="["
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX="] "
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_TRUNC=2
SPACESHIP_GIT_STATUS_SHOW="false"
SPACESHIP_GIT_PREFIX=""

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
alias lf="~/.config/lf/lfub.sh"

# Display random pokemon :)
pokemon-colorscripts -r 1-4
