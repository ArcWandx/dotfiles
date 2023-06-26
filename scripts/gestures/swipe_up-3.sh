#!/bin/zsh
export DISPLAY=:0
app=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk -F '"' '{print $4}')

case "$app" in
	discord)
		;;
	*kitty)
		if [[ -z $(xprop -id $(xdotool getactivewindow) WM_NAME | grep "nvim") ]]; then
			xdotool key ctrl+d
		else
			xdotool key shift+z shift+z
		fi
		;;
	*)
		xdotool key ctrl+w
		;;
esac
