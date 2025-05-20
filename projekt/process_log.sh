#!/bin/bash

LOGFILE="system_monitor.log"

if [ ! -f "$LOGFILE" ]; then
  echo "A logfájl nem található: $LOGFILE"
  exit 1
fi

LAST_10_MINUTES=$(date -d "-10 minutes" "+%Y-%m-%d %H:%M:%S")
FILTERED_LOG=$(awk -v start="$LAST_10_MINUTES" '$1" "$2 >= start' "$LOGFILE")

AVG_CPU=$(echo "$FILTERED_LOG" | awk -F 'CPU: |%' '{sum+=$2; count++} END {if (count > 0) print sum/count; else print 0}')
MAX_CPU=$(echo "$FILTERED_LOG" | awk -F 'CPU: |%' '{if ($2 > max) max=$2} END {print max}')
MIN_CPU=$(echo "$FILTERED_LOG" | awk -F 'CPU: |%' '{if (NR == 1 || $2 < min) min=$2} END {print min}')

AVG_MEM=$(echo "$FILTERED_LOG" | awk -F 'Memory: ' '{split($2, a, "%"); sum+=a[1]; count++} END {if (count > 0) print sum/count; else print 0}')
MAX_MEM=$(echo "$FILTERED_LOG" | awk -F 'Memory: ' '{split($2, a, "%"); if (a[1] > max) max=a[1]} END {print max}')
MIN_MEM=$(echo "$FILTERED_LOG" | awk -F 'Memory: ' '{split($2, a, "%"); if (NR == 1 || a[1] < min) min=a[1]} END {print min}')

echo "Átlagos CPU: ${AVG_CPU}%, Átlagos memória: ${AVG_MEM}%"
echo "Legmagasabb CPU: ${MAX_CPU}%, Legmagasabb memória: ${MAX_MEM}%"
echo "Legalacsonyabb CPU: ${MIN_CPU}%, Legalacsonyabb memória: ${MIN_MEM}%"
