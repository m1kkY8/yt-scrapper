#!/usr/bin/env bash

node "./index.js" 

soung_count=$(wc -l < ./music_links)
echo "Downloading $soung_count songs"

while read -r line; do
    yt-dlp --no-write-description -q --no-playlist --extract-audio --add-metadata --audio-format mp3 "$line"
done < ./music_links 

echo "Done downloading songs"
echo "Clearing links file"

> ./music_links 

echo "Moving songs to Music folder"

mv *.mp3 "$HOME/Music/"
