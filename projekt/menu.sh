#!/bin/bash

function display_menu {
    echo "1. Rendszerfigyelés és logolás indítása"
    echo "2. Trendek elemzése az utolsó 10 percből"
    echo "3. Riasztások megtekintése"
    echo "4. Grafikon készítése a CPU használatról"
    echo "5. Adatok exportálása JSON formátumba"
    echo "6. Kilépés"
    echo -n "Válassz egy lehetőséget: "
}

while true; do
    display_menu
    read -r choice

    case $choice in
        1)
            echo "Rendszerfigyelés indítása..."
            bash system_monitor.sh
            ;;
        2)
            echo "Trendek elemzése..."
            bash process_log.sh
            ;;
        3)
            echo "Riasztások megtekintése..."
            bash alert.sh
            ;;
        4)
            echo "Grafikon készítése..."
            bash generate_graph.sh
            ;;
        5)
            echo "Adatok exportálása JSON formátumba..."
            bash convert_to_json.sh
            ;;
        6)
            echo "Kilépés..."
            break
            ;;
        *)
            echo "Helytelen választás, próbáld újra."
            ;;
    esac
done
