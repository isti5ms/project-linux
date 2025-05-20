#!/bin/bash

LOGFILE="system_monitor.log"
OUTPUT_FILE="output.json"

echo "{" > $OUTPUT_FILE

first_line=true
while IFS=, read -r timestamp cpu memory download upload
do
    cpu=${cpu//CPU: /}
    cpu=${cpu//%/}
    memory=${memory//Memory: /}
    memory=${memory//%/}
    download=${download//Download: /}
    upload=${upload//Upload: /}

    if [ "$first_line" = true ]; then
        first_line=false
    else
        echo "," >> $OUTPUT_FILE
    fi

    echo "  \"$timestamp\": {\"CPU\": \"$cpu%\", \"Memory\": \"$memory%\", \"Download\": \"$download KiB/s\", \"Upload\": \"$upload KiB/s\"}" >> $OUTPUT_FILE

done < $LOGFILE

echo "}" >> $OUTPUT_FILE

echo "JSON file successfully created: $OUTPUT_FILE"
