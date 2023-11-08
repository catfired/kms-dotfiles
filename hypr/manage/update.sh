#!/usr/bin/env bash

notify_flag=$1

notify_core () {
	if [[ $notify_flag == "--notify" ]]; then
		notify-send "Rice Update Manager" "$1" $2
	fi
}

notify () {
	notify_core "$1" ""
}

critical_notify () {
	notify_core "$1" "-u critical"
}

missing_array=()

missing () {
	missing_array+=("$1")
}

configs=()

add_conf () {
	configs+=("$1" "$2" "$3" "$4")
}

add_conf "$HOME/.config/hypr/" "Hyprland" "origin" "main"
add_conf "$HOME/.config/alacritty/" "Alacritty" "origin" "main"
add_conf "$HOME/.config/kitty/" "Kitty" "origin" "main"
add_conf "$HOME/.config/rofi/" "Rofi" "origin" "main"

for u in $(seq 0 $((${#configs[@]} / 3)))
do
	codir=""
	coname=""
	coorigin=""
	comain=""

	for i in $(seq 0 3)
	do
		if [[ $i == 0 ]]; then
			codir=${configs[$(($((u * 4)) + $i))]}
		elif [[ $i == 1 ]]; then
			coname=${configs[$(($((u * 4)) + $i))]}
		elif [[ $i == 2 ]]; then
			coorigin=${configs[$(($((u * 4)) + $i))]}
		elif [[ $i == 3 ]]; then
			comain=${configs[$(($((u * 4)) + $i))]}
		fi
	done

	if [[ -d "$codir" ]]; then
		notify "Updating... $coname"
		cd "$codir"
		git pull "$coorigin" "$comain"
	else
		missing "$coname"
	fi
done

cd ~

if [[ ${#missing_array} != 0 ]]; then
	echo ""
fi

for i in "${missing_array[@]}"
do
	if [[ $i != "" ]]; then
		if [[ $i != " " ]]; then
			echo -e "\033[1;30m[\033[1;36mMissing\033[1;30m]\033[0m \033[0;31mYou are missing config files for $i.\033[0m"
			critical_notify "No config for $i!"
		fi
	fi
done

notify "Done! :-D"
