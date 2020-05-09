#! /bin/bash

rofi_cmd="rofi -theme $HOME/.config/polybar/scripts/powermenu.rasi"

shutdown=""
reboot=""
suspend="鈴"
logout=""
lock=""

options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

choice="$(echo -e "$options" | $rofi_cmd -dmenu -selected-row 0)"

case $choice in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        i3-msg exit
        ;;
    $lock)
        i3-lock
        ;;
esac
