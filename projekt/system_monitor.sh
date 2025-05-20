#!/bin/bash

while true;
do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    MEM_USAGE=$(free | grep Mem | awk '{printf("%.2f", $3/$2 * 100)}')

    NET_STATS=$(vnstat --oneline | awk -F';' '{print $9", "$10}')
    DOWNLOAD=$(echo "$NET_STATS" | cut -d',' -f1 | sed 's/ KiB//')
    UPLOAD=$(echo "$NET_STATS" | cut -d',' -f2 | sed 's/ KiB//')

    echo "$TIMESTAMP, CPU: ${CPU_USAGE}%, Memory: ${MEM_USAGE}%, Download: ${DOWNLOAD} KiB/s, Upload: ${UPLOAD} KiB/s" >> system_monitor.log
    sleep 2
done
