#! /bin/bash

rofi_theme=/home/$USER/.config/rofi/theme_switcher.rasi
rofi_cmd="rofi -theme $rofi_theme -dmenu -selected-row 0 -markup-rows"

wallpapers_dir=/media/shared/wallpapers
palettes_dir=/home/$USER/.config/hapycolor_palettes
hapycolor_dir=/home/$USER/.config/hapycolor
rofi_dir=/home/$USER/.config/rofi

palette_config_file_Xresources=$palettes_dir/.hapycolor.Xresources
palette_config_file_rasi=$rofi_dir/hapycolor.rasi

nb_max_rows=36  # to set manually according to preferences
max_name_len=15  # to set manually to fit window width
options_save_file=/home/$USER/.cache/theme_switcher_options


refresh="refresh new themes"
refresh_all="refresh all themes"

# compute nb rows of menu

nb_wallpapers=$(ls $wallpapers_dir | wc -l)
nb_total_rows=$(($nb_wallpapers + 2))
nb_rows=$nb_total_rows
divisor=1
while [[ $nb_rows -gt $nb_max_rows ]]; do
    divisor=$(($divisor + 1))
    if [[ $(($nb_total_rows % $divisor)) -ne 0 ]]; then
        nb_rows=$(($nb_total_rows / $divisor + 1))
    else
        nb_rows=$(($nb_total_rows / $divisor))
    fi
done

# try to load cache themes descriptions
if [[ -f $options_save_file ]]; then
    options=$(cat $options_save_file)
    options="${options}"$'\n'

else
    # add palette colors next to palette name
    options=""
    for image_name in $(ls $wallpapers_dir); do
        image_name=$(echo $image_name | xargs basename | sed -e 's/\..*//')
        name=$image_name
        if [[ ${#name} -gt ${max_name_len} ]]; then
            name=${name:0:${max_name_len}}
        fi
        options="${options}${name}  "

        Xresources=$palettes_dir/$image_name.Xresources

        if [[ -f $Xresources ]]; then
            for i in {0..15}; do
                hex_code=$(cat $Xresources | grep "color$i:" | awk -F '#' '{print $2}')
                hex_code=${hex_code^^}
                options="${options}<span foreground=\"#${hex_code}\">██</span>"
            done
        else
            options="${options}                "
            options="${options}                "
        fi
        options="${options}"$'\n'
    done
    echo -e "$options" > $options_save_file
fi

choice="$(echo -e "$options$refresh\n$refresh_all" | $rofi_cmd -l $nb_rows)"

case $choice in
    "")
        ;;
    $refresh)
        rm -f $options_save_file
        cd $hapycolor_dir
        python3 -m hapycolor --dir $wallpapers_dir --Xresources --rasi $palettes_dir &
        ;;
    $refresh_all)
        rm -f $options_save_file
        palette_save_Xresources=/tmp/hapy_palette_save.Xresources
        palette_save_rasi=/tmp/hapy_palette_save.rasi
        cp $palette_config_file_Xresources $palette_save_Xresources
        cp $palette_config_file_rasi $palette_save_rasi
        rm -f $palettes_dir/*
        cp $palette_save_Xresources $palette_config_file_Xresources
        cp $palette_save_rasi $palette_config_file_rasi
        cd $hapycolor_dir
        python3 -m hapycolor --dir $wallpapers_dir --Xresources --rasi $palettes_dir --refresh &
        ;;
    *)
        palette_short_name=$(echo $choice | awk -F ' ' '{print $1}')
        if [[ ${#palette_short_name} -le $max_name_len ]]; then
            wallpaper=$(ls $wallpapers_dir | grep "^$palette_short_name\.")
        else
            wallpaper=$(ls $wallpapers_dir | grep "^$palette_short_name")
        fi
        palette_name=${wallpaper%.*}
        cp $palettes_dir/$palette_name.Xresources $palette_config_file_Xresources
        cp $palettes_dir/$palette_name.rasi $palette_config_file_rasi
        cp $wallpapers_dir/$wallpaper ~/.config/wallpaper.jpg
        regolith-look refresh
        polybar-msg cmd restart
        ;;
esac
