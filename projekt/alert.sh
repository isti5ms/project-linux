#!/bin/bash

CPU_MAX=12
while true;
do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    if (( $(echo "$CPU_USAGE > $CPU_MAX" | bc -l) ));
        then
          echo "[ALERT] $TIMESTAMP: CPU athaladta a ${CPU_MAX}%-ot (${CPU_USAGE}%)" >> "alerts.log"
    fi

    sleep 2
done
