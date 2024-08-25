#!/usr/bin/env bash

# Function to clean up and exit
cleanup() {
    echo "Stopping playback and Asciiquarium..."
    pkill -P $$ # Kill all child processes started by this script
    exit 0
}

# Trap SIGINT (Ctrl+C) to call cleanup
trap cleanup SIGINT

# Get the directory of the script, resolving symlinks
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}" || echo "${BASH_SOURCE[0]}")")" && pwd)"

# Start the MP3 playback in the background, suppressing output
ffplay -nodisp -loop 0 "$SCRIPT_DIR/aquarium.mp3" &>/dev/null &

# Run asciiquarium in the foreground
"$SCRIPT_DIR/asciiquarium"

# Cleanup when asciiquarium exits
cleanup
