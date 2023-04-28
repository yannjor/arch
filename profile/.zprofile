export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.bin"
# Default programs
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
# File manager icons
LF_ICONS=$(sed ~/.config/lf/icons  \
            -e '/^[ \t]*#/d'       \
            -e '/^[ \t]*$/d'       \
            -e 's/[ \t]\+/=/g'     \
            -e 's/$/ /')
LF_ICONS=${LF_ICONS//$'\n'/:}
export LF_ICONS
