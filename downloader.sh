#!/usr/bin/env bash

DIR="$HOME/projects/yt-scraper"

node "$DIR/index.js" 

soung_count=$(wc -l < "$DIR/music_links")
echo "Downloading $soung_count songs"

while read -r line; do
    yt-dlp --no-write-description -q --no-playlist --extract-audio --add-metadata --audio-format mp3 "$line"
done < "$DIR/music_links" 

echo "Done downloading songs"
echo "Clearing links file"

> "$DIR/music_links" 

echo "Moving songs to Music folder"

mv *.mp3 "$HOME/Music/"
