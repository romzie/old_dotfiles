#! /bin/bash

rofi_cmd="rofi -theme $HOME/.config/polybar/scripts/theme_switcher.rasi -dmenu -selected-row 0 -markup-rows"

wallpapers_dir=/media/shared/wallpapers
palettes_dir=/home/$USER/.config/hapycolor_palettes
hapycolor_dir=/home/$USER/.config/hapycolor
palette_config_file=$palettes_dir/.hapycolor.Xresources
nb_max_rows=36  # to set manually according to preferences
max_name_len=10  # to set manually to fit window width


refresh="refresh new themes"
refresh_all="refresh all themes"

# compute nb rows of menu

nb_wallpapers=$(ls $wallpapers_dir | wc -l)
nb_rows=$(($nb_wallpapers + 2))
if [[ $nb_rows -gt $nb_max_rows ]]; then
    if [[ $(($nb_rows % $nb_max_rows)) -gt $(($nb_rows % ($nb_max_rows - 1))) ]]; then
        nb_rows=$nb_max_rows
    else
        nb_rows=$(($nb_max_rows - 1))
    fi
fi

# add palette colors next to palette name
options=""
for palette in $(ls $palettes_dir); do
    name=$(echo $palette | sed -e 's/\.Xresources//')
    if [[ ${#name} -gt ${max_name_len} ]]; then
        name=${name:0:${max_name_len}}
    fi


    Xresources=$palettes_dir/$palette
    options="${options}${name}  "
    for i in {0..15}; do
        hex_code=$(cat $Xresources | grep "color$i:" | awk -F '#' '{print $2}')
        hex_code=${hex_code^^}
        options="${options}<span foreground=\"#${hex_code}\">██</span>"
    done
    options="${options}"$'\n'
done

choice="$(echo -e "$options$refresh\n$refresh_all" | $rofi_cmd -l $nb_rows)"

case $choice in
    "")
        ;;
    $refresh)
        cd $hapycolor_dir
        python3 -m hapycolor --dir $wallpapers_dir --Xresources $palettes_dir &
        ;;
    $refresh_all)
        palette_save=/tmp/hapy_palette_save.Xresources
        cp $palette_config_file $palette_save
        rm -f $palettes_dir/*
        cp $palette_save $palette_config_file
        cd $hapycolor_dir
        python3 -m hapycolor --dir $wallpapers_dir --Xresources $palettes_dir --refresh &
        ;;
    *)
        palette_chosen=$(echo $choice | awk -F ' ' '{print $1}')
        cp $palettes_dir/$palette_chosen.Xresources $palette_config_file
        regolith-look refresh
        bash /home/$USER/.config/polybar/launch.sh &
        ;;
esac
