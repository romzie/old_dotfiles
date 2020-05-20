#! /bin/bash

symbols="BNP.PA AIR.PA GLE.PA AC.PA"

stocks_cmd="python3 /home/$USER/.config/polybar/scripts/get_stock.py --symbols $symbols"

sleep_duration=20
long_sleep=3600

weekday=$(date "+%u")

if [[ $weekday == "6" || $weekday == "7" ]]; then
    sleep_duration=$long_sleep
fi

while :
do
    dayhour=$(date "+%k")

    if [[ $dayhour -lt 8 || $dayhour -gt 18 ]]; then
        sleep_duration=$long_sleep
    fi

    $stocks_cmd | while read -r line; do
        echo $line
        sleep $sleep_duration
    done
done
