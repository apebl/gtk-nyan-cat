#!/usr/bin/env bash
set -e
set -o xtrace

cd "$(dirname "${BASH_SOURCE[0]}")"
FLAVOR="$1"
THEME_DIR="$2"

mkdir -p "$THEME_DIR/gtk-3.0/nyan-cat"
cp -r "flavors/$FLAVOR/." "$THEME_DIR/gtk-3.0/nyan-cat"
cp "nyan-cat.css" "$THEME_DIR/gtk-3.0"

if [ ! -f "$THEME_DIR/gtk-3.0/gtk.main.css" ]; then
	mv "$THEME_DIR/gtk-3.0/gtk.css" "$THEME_DIR/gtk-3.0/gtk.main.css"
fi

cat << EOF > "$THEME_DIR/gtk-3.0/gtk.css"
@import url("gtk.main.css");
@import url("nyan-cat.css");
EOF

if [ -f "$THEME_DIR/gtk-3.0/gtk-dark.css" ]; then
	if [ ! -f "$THEME_DIR/gtk-3.0/gtk-dark.main.css" ]; then
		mv "$THEME_DIR/gtk-3.0/gtk-dark.css" "$THEME_DIR/gtk-3.0/gtk-dark.main.css"
	fi

	cat << EOF > "$THEME_DIR/gtk-3.0/gtk-dark.css"
@import url("gtk-dark.main.css");
@import url("nyan-cat.css");
EOF
fi
