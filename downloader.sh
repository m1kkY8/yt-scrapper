#!/usr/bin/env bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

"$DIR/reader"

node "$DIR/index.js" 

song_count=$(wc -l < "$DIR/queries")

if [[ "$song_count" -eq 0 ]]; then
    echo "No songs to download"
    exit 1
else
    echo "Downloading $song_count song/s"
fi

if [[ -s "$DIR/queries" ]]; then
    while read -r line; do
        yt-dlp --no-write-description -q --progress --newline \
            --no-playlist --extract-audio --add-metadata\
            --audio-format mp3 --audio-quality 0 \
            --output "%(title)s.%(ext)s" \
            "$line"

    done < "$DIR/queries" 
else
    exit 1
fi

echo "Done downloading songs"
echo "Clearing links file"

> "$DIR/queries" 

echo "Moving songs to Music folder"

count=$(ls -1 *.mp3 2>/dev/null | wc -l)

if [[ "$count" -ne 0 ]]; then
    mv *.mp3 ~/Music
    echo "Moved $count song/s to Music folder"
else
    echo "No songs to move"
fi
