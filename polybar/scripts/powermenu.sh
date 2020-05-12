#! /bin/bash

rofi_theme=/home/$USER/.config/rofi/powermenu.rasi
rofi_cmd="rofi -theme $rofi_theme -dmenu -selected-row 0"

shutdown=""
reboot=""
suspend=""
logout=""
lock=""

options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

choice="$(echo -e "$options" | $rofi_cmd)"

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
