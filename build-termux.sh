#!/usr/bin/env bash

set -e

pr() { echo -e "\033[0;32m[+] ${1}\033[0m"; }
ask() {
	local y
	for ((n = 0; n < 3; n++)); do
		pr "$1 [y/n]"
		if read -r y; then
			if [ "$y" = y ]; then
				return 0
			elif [ "$y" = n ]; then
				return 1
			fi
		fi
		pr "Asking again..."
	done
	return 1
}

pr "Ask for storage permission"
until
	yes | termux-setup-storage >/dev/null 2>&1
	ls /sdcard >/dev/null 2>&1
do sleep 1; done
if [ ! -f ~/.rvmm_"$(date '+%Y%m')" ]; then
	pr "Setting up environment..."
	yes "" | pkg update -y && pkg upgrade -y && pkg install -y git curl jq openjdk-17 zip
	: >~/.rvmm_"$(date '+%Y%m')"
fi
mkdir -p /sdcard/Download/morphe-magisk-module/

if [ -d morphe-magisk-module ] || [ -f config.toml ]; then
	if [ -d morphe-magisk-module ]; then cd morphe-magisk-module; fi
	pr "Checking for morphe-magisk-module updates"
	git fetch
	if git status | grep -q 'is behind\|fatal'; then
		pr "morphe-magisk-module is not synced with upstream."
		pr "Cloning morphe-magisk-module. config.toml will be preserved."
		cd ..
		cp -f morphe-magisk-module/config.toml .
		rm -rf morphe-magisk-module
		git clone https://github.com/kmdtaufik/morphe-magisk-module --recurse --depth 1
		mv -f config.toml morphe-magisk-module/config.toml
		cd morphe-magisk-module
	fi
else
	pr "Cloning morphe-magisk-module."
	git clone https://github.com/kmdtaufik/morphe-magisk-module --depth 1
	cd morphe-magisk-module
	sed -i '/^enabled.*/d; /^\[.*\]/a enabled = false' config.toml
	grep -q 'morphe-magisk-module' ~/.gitconfig 2>/dev/null ||
		git config --global --add safe.directory ~/morphe-magisk-module
fi

[ -f ~/storage/downloads/morphe-magisk-module/config.toml ] ||
	cp config.toml ~/storage/downloads/morphe-magisk-module/config.toml

if ask "Open rvmm-config-gen to generate a config?"; then
	am start -a android.intent.action.VIEW -d https://j-hc.github.io/rvmm-config-gen/
fi
printf "\n"
until
	if ask "Open 'config.toml' to configure builds?\nAll are disabled by default, you will need to enable at first time building"; then
		am start -a android.intent.action.VIEW -d file:///sdcard/Download/morphe-magisk-module/config.toml -t text/plain
	fi
	ask "Setup is done. Do you want to start building?"
do :; done
cp -f ~/storage/downloads/morphe-magisk-module/config.toml config.toml

./build.sh

cd build
PWD=$(pwd)
for op in *; do
	[ "$op" = "*" ] && {
		pr "glob fail"
		exit 1
	}
	mv -f "${PWD}/${op}" ~/storage/downloads/morphe-magisk-module/"${op}"
done

pr "Outputs are available in /sdcard/Download/morphe-magisk-module folder"
am start -a android.intent.action.VIEW -d file:///sdcard/Download/morphe-magisk-module -t resource/folder
sleep 2
am start -a android.intent.action.VIEW -d file:///sdcard/Download/morphe-magisk-module -t resource/folder
