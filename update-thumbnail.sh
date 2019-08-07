#!/usr/bin/env bash
set -e
./demo.py &
sleep 1
shutter --window="Nyan Cat Demo" -o thumbnail.png
