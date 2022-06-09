#!/usr/bin/env bash
# Script to remove leading slash for each line of a file.
# Focus was made on readability for the maintenance.
# Sources:
# https://linuxhint.com/trim_string_bash/
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
if [ "$#" -lt 1 ]; then
    script_name=$(basename "$0")
    echo "Usage:"
    echo "   $script_name [FILE_TO_PROCESS]"
    echo ""
    echo "Call example:"
    echo "    $script_name common.txt"
    exit 1
fi
source_file="$1"
echo "[+] Source file: $source_file"
wc -l $source_file
source_filename=$(basename $source_file)
output_file="/tmp/$source_filename"
rm $output_file 2>/dev/null
while IFS= read -r word
do
    word_left_space_trimmed=${word##*( )}    
    first_letter=${word_left_space_trimmed:0:1}
    new_word=$word_left_space_trimmed
    if [ $first_letter == "/" ];
    then
        echo ${new_word:1} >> $output_file
    else
        echo $new_word >> $output_file
    fi

done < "$source_file"
echo "[+] Result file: $output_file"
wc -l $output_file