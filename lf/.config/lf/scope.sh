#!/bin/sh

# File preview handler for lf.

set -C -f
IFS="$(printf '%b_' '\n')"
IFS="${IFS%_}"

check_cache() {
    if [ ! -d "$HOME/.cache/lf" ]; then
        mkdir -p "$HOME/.cache/lf"
    fi
}

image() {
    kitty +kitten icat --transfer-mode file --place "$3x$2@$4x$5" "$1"
}

draw_clear() {
    kitty +kitten icat --transfer-mode file --clear
}

check_cache
draw_clear
case "$(file --dereference --brief --mime-type -- "$1")" in
    image/*) image "$1" "$2" "$3" "$4" "$5" ;;
    text/troff) man ./ "$1" | col -b ;;
    text/* | */xml | application/json) bat --terminal-width "$4" -f "$1" ;;
    application/zip) atool --list -- "$1" ;;
    audio/* | application/octet-stream) mediainfo "$1" || exit 1 ;;
    video/*)
        CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
        [ ! -f "$CACHE" ] && ffmpegthumbnailer -i "$1" -o "$CACHE" -s 0
        image "$CACHE" "$2" "$3" "$4" "$5"
        ;;
    */pdf)
        CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
        [ ! -f "$CACHE.jpg" ] && pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
        image "$CACHE.jpg" "$2" "$3" "$4" "$5"
        ;;
esac
exit 1
