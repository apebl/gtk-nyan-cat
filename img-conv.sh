#!/usr/bin/env bash
set -e

CAT="$1" # gif
THUMB="$2" # gif
RAINBOW="$3"
NAME="$(basename "$CAT")"
NAME="${NAME%.*}"
CATDIR="flavors/$NAME"

mkdir -p "$CATDIR"
convert -verbose -coalesce -resize 25% -filter box "$CAT" "$CATDIR/cat.png"
convert -verbose -coalesce -resize 25% -filter box -flop "$CAT" "$CATDIR/cat-reverse.png"
convert -verbose -coalesce -resize 500% -filter box "$THUMB" "$CATDIR/cat-spin.png"
if [ ! -z "$RAINBOW" ]; then
	cp -v "$RAINBOW" "$CATDIR/rainbow.png"
	convert -verbose -rotate 270 "$RAINBOW" "$CATDIR/rainbow-vertical.png"
fi
cd "$CATDIR"
exiftool -all= -overwrite_original *
