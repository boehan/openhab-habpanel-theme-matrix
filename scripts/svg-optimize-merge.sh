#!/bin/sh

SOURCE_FOLDER=$1
FILENAME=$2
TARGET_FOLDER="/etc/openhab2/html/matrix-theme/"

# optimize raw .svg-files in 
svgo $SOURCE_FOLDER --disable=removeViewBox

# join the optimized files to a single svg
svg-join -s "$SOURCE_FOLDER*.svg" -o $TARGET_FOLDER -n $FILENAME
