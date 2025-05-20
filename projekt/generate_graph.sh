#!/bin/bash

if [[ ! -f system_monitor.log ]]; then
    echo "[ERROR] A 'system_monitor.log' fájl nem található!"
    exit 1
fi

awk -F", " '{print NR, $2}' system_monitor.log | sed 's/CPU: //' | sed 's/%//' > cpu_usage.txt

gnuplot -e "set terminal png; set output 'cpu_usage.png'; plot 'cpu_usage.txt' using 1:2 with lines title 'CPU használat'"

if [[ -f cpu_usage.png ]]; then
    echo "[INFO] Grafikon sikeresen elkészült: cpu_usage.png"
    if command -v xdg-open &> /dev/null; then
        xdg-open cpu_usage.png
    else
        echo "[INFO] Az 'xdg-open' parancs nem található, kérlek nyisd meg kézzel a 'cpu_usage.png' fájlt."
    fi
else
    echo "[ERROR] Nem sikerült létrehozni a grafikont!"
fi
