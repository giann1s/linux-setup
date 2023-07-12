#!/usr/bin/env bash

LOC=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $LOC/config/options.sh

# Verify arguments
if [[ $# -gt 1 ]] || [[ $1 != @(""|"delete") ]] then
    exit
fi

if [[ $1 == "delete" ]] then
    rm -rf $LOC/config/app-data/dotconfig/*
    rm -rf $LOC/config/app-data/flatpaks-data/*
    exit
fi

# App data
for dir in "${dotconfig_dirs[@]}"; do
    cp -r  ~/.config/$dir $LOC/config/app-data/dotconfig
done

# Flatpaks data
excluded_folders=( "cache" ".ld.so" )   # Folders of each flatpak to ignore
for flatpak_id in $(ls ~/.var/app); do
    for folder in $(ls -A ~/.var/app/$flatpak_id); do
        if [[ ! "${excluded_folders[*]}" =~ "${folder}" ]]; then
            mkdir -p $LOC/config/app-data/flatpaks-data/$flatpak_id
            cp -r ~/.var/app/$flatpak_id/$folder $LOC/config/app-data/flatpaks-data/$flatpak_id
        fi
    done
done
