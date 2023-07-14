#!/usr/bin/env bash

# Location of script
LOC=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $LOC/config/options.sh

distro=$1

# Verify arguments
if [[ $# != 1 ]] || [[ ! " ${distros[*]} " =~ " ${distro} " ]] then
    exit
fi

# Exit if script is being run as root
if [[ "`whoami`" == "root" ]]; then
    echo -e "Please do NOT run the script as root."
    exit
fi
# Ask for root privileges
sudo true

# Distro-specific configuration
# We need this first to ensure that all the required
# packages are installed before further changes.
case $distro in

"debian")

    # This is the defualt .bashrc with a few lines
    # added to run the .bashrc files in ~/.bashrc.d
    cp $LOC/res/debian.bashrc ~/.bashrc

    sudo apt-get purge -y --autoremove ${deb_packages_remove[@]}
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y ${deb_packages[@]}

    # Configure firewall
    echo "Configuring firewall..."

    sudo ufw default deny incoming  # Default Rules
    sudo ufw default allow outgoing

    sudo ufw allow 80/tcp           # HTTP / HTTPS
    sudo ufw allow 443/tcp

    sudo ufw limit 22/tcp           # SSH
    
    sudo ufw enable

    if [[ $set_governor ]] then
        # Check current cpu governor
        # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

        sudo apt-get install -y linux-cpupower
        
        sudo cp $LOC/res/cpupower.service /etc/systemd/system
        sudo sed -i "s/cpu_governor/$cpu_governor/g" /etc/systemd/system/cpupower.service

        sudo systemctl enable --now cpupower.service
    fi

    if [[ $use_flatpak ]] then
        sudo apt-get install -y flatpak
    fi
    
    ;;

esac

# General configuration
if [[ $use_flatpak ]] then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y ${flatpaks[@]}

    # Firefox flatpak workaround for fonts (https://github.com/flatpak/flatpak/issues/4571)
    mkdir -p ~/.var/app/org.mozilla.firefox/config/fontconfig/conf.d
    rm -rf ~/.var/app/org.mozilla.firefox/config/fontconfig/conf.d/*
    cp /etc/fonts/conf.d/*.conf ~/.var/app/org.mozilla.firefox/config/fontconfig/conf.d
fi

# Configuration files
cp -r $LOC/config/bash/.bashrc.d ~/

# Backup
if [[ $restore_backup ]] then

    # App data
    mkdir ~/.config &> /dev/null
    for data_dir in $(ls $LOC/config/app-data/dotconfig); do
        if [[ -d ~/.config/$data_dir ]] then
            rm -rf ~/.config/$data_dir
        fi
    done
    cp -r $LOC/config/app-data/dotconfig/* ~/.config

    # Flatpaks data
    if [[ $(ls $LOC/config/app-data/flatpaks-data) != "" ]] then
        mkdir -p ~/.var/app
        for flatpak_id in $(ls $LOC/config/app-data/flatpaks-data); do
            if [[ -d ~/.var/app/$flatpak_id ]] then
                rm -rf ~/.var/app/$flatpak_id
            fi
        done
        cp -r $LOC/config/app-data/flatpaks-data/* ~/.var/app
    fi
fi
