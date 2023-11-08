#!/usr/bin/env bash

configs=(
    "Hyprland Rice" "$HOME/.config" "hypr" "https://gitlab.com/Oglo12/hyprland-rice.git"
    "Alacritty" "$HOME/.config" "alacritty" "https://gitlab.com/Oglo12/hyprland-alacritty.git"
    "Kitty" "$HOME/.config" "kitty" "https://gitlab.com/Oglo12/hyprland-kitty.git"
    "Rofi" "$HOME/.config" "rofi" "https://gitlab.com/Oglo12/hyprland-rofi.git"
)

for u in $(seq 0 $((${#configs[@]} / 3))); do
    coname=""
    codir=""
    foname=""
    gitrl=""

    for i in $(seq 0 3); do
        cfgsv=${configs[$(($((u * 4)) + $i))]}

        if [[ $i == 0 ]]; then
			coname="$cfgsv"
        elif [[ $i == 1 ]]; then
            codir="$cfgsv"
        elif [[ $i == 2 ]]; then
            foname="$cfgsv"
        elif [[ $i == 3 ]]; then
            gitrl="$cfgsv"
        fi
    done

    if [[ $gitrl != "" ]]; then
        echo "[i] => Setting up $coname..."

        if [[ -d $codir ]]; then
            echo -e "\033[0;31mIf you see this, it is a bug.\033[0m" > /dev/null
        else
            mkdir -p $codir
        fi

        cd $codir

        get_mode=""

        if [[ -d $foname ]]; then
            echo "The directory $codir/$foname already exists, what now?"
            echo " "
            echo "1. Overwrite it."
            echo "2. Overwrite it and make a backup. (Recommended)"
            echo "3. Skip it."
            echo " "

            while [[ 1 == 1 ]]; do
                read -p "Number: " ask_mode

                if [[ $ask_mode == 1 ]]; then
                    get_mode="overwrite"
                    break
                elif [[ $ask_mode == 2 ]]; then
                    get_mode="backup"
                    break
                elif [[ $ask_mode == 3 ]]; then
                    get_mode="skip"
                    break
                else
                    echo "Invalid option, asking again."
                fi
            done
        else
            get_mode="populate"
        fi

        if [[ $get_mode == "populate" ]]; then
            git clone "$gitrl" "$foname"
        elif [[ $get_mode == "overwrite" ]]; then
            rm -rf "$foname"
            git clone "$gitrl" "$foname"
        elif [[ $get_mode == "backup" ]]; then
            mv "$foname" "${foname}_BACKUP"
            git clone "$gitrl" "$foname"
        elif [[ $get_mode == "skip" ]]; then
            echo "Skipping $coname..."
        fi

        echo " "
    fi

    cd "$HOME"
done

cd "$HOME"

echo "Installing Nerd Fonts..."

nerd_font="JetBrainsMono"
nerd_font_version="3.0.1"

mkdir -p $HOME/.fonts
cd $HOME/.fonts

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v${nerd_font_version}/${nerd_font}.zip"

unzip "${nerd_font}.zip"

rm OFL.txt
rm readme.md
rm "${nerd_font}.zip"

fc-cache

echo " "

cd "$HOME"

echo "Done!"
