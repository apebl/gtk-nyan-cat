#!/usr/bin/env bash
set -e

NAME="$1"
THUMB="$([ -z "$2" ] && echo "$NAME" || echo "$2")"

wget -O "$NAME.gif" "http://www.nyan.cat/cats/$NAME.gif"
wget -O "$NAME-thumb.gif" "http://www.nyan.cat/images/thumbs/$THUMB.gif"
