#! /bin/bash

stocks_cmd="python3 /home/$USER/.config/polybar/scripts/get_stock.py --short"

sleep_duration=20
long_sleep=3600

weekday=$(date "+%u")

if [[ $weekday == "6" || $weekday == "7" ]]; then
    sleep_duration=$long_sleep
fi

while :
do
    dayhour=$(date "+%H")

    if [[ $dayhour -lt 8 || $dayhour -gt 18 ]]; then
        sleep_duration=$long_sleep
    fi

    $stocks_cmd | while read -r line; do
        echo $line
        sleep $sleep_duration
    done
done
