#!/bin/zsh
# Make sure script is run from the directory it is in
cd "$(dirname "$0")"

# Update directories that cannot be hard linked
function up_dir {
	rsync -a --delete $1 ./$2
}
function up_file {
	cp $1 ./$2
}

up_dir ~/.config/bspwm
up_dir ~/.config/sxhkd
up_dir ~/.config/mpv
up_dir ~/scripts
up_dir /etc/X11/xorg.conf.d
up_file ~/.config/BetterDiscord/themes/nocturnal.theme.css
up_file ~/.config/X11/xinitrc
up_file ~/.config/tridactyl/tridactylrc

# If the script is called without parameters,
# allow for manual committing
if [[ -z "$1" ]]; then
	exit
fi

# Check diffs
if [[ "$1" = "-d" ]]; then
	git diff
	exit
fi

# Auto-commit everything
if [[ -a "$1" ]]; then
	git add .
	if [[ -z "$2" ]]; then
		git commit -m "Update dotfiles"
	else
		git commit -m "$2"
	fi
	git push
fi
