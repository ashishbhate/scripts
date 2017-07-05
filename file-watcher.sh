#!/bin/bash
if [ $# -lt 3 ]
then
    echo "Usage $0 file pattern script"
    exit
fi

file_to_watch=$1
pattern=$2
script_to_run=$3
line_count_file=$(mktemp)
matched_text_file=$(mktemp)

wc -l "$file_to_watch" |  awk '{print $1}' > "$line_count_file"

while inotifywait -e modify "$file_to_watch"; do
    prev_line_count="$(cat $line_count_file)"
    current_line_count="$(wc -l "$file_to_watch" |  awk '{print $1}')"
    echo "$current_line_count" > "$line_count_file"
    if [ $current_line_count -gt $prev_line_count ]
    then
        new_line_count="$(expr $current_line_count - $prev_line_count)"
        if tail -n$new_line_count "$file_to_watch" | grep -i "$2" | tee "$matched_text_file";
        then
            while IFS=" " read -r line
            do
                line_escaped="${line//;/,}"
                line_escaped="${line_escaped//&/AND}"
                "$script_to_run" "$line_escaped" "$line_escaped"
            done <"$matched_text_file"
        fi
    fi
done
