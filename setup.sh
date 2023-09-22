#!/usr/bin/env bash

# Location of script
LOC=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

distro=$1

source $LOC/config/options.sh

# Verify arguments
if [[ $# != 1 ]] || [[ ! " ${distros[*]} " =~ " ${distro} " ]]; then
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
    cp $LOC/res/debian/.bashrc ~

    # The bat executable have been renamed from ‘bat’ to ‘batcat’
    # because of a file name clash with another Debian package,
    # so an alias is necessary to use bat with the regular command.
    mkdir -p ~/.bashrc.d
    cp $LOC/res/debian/bat.bashrc ~/.bashrc.d
    
    # Add VSCodium Repository
    wget --inet4-only -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/vscodium-archive-keyring.gpg --yes
    echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo dd of=/etc/apt/sources.list.d/vscodium.list status=none

    sudo apt-get install nala -y
    sudo nala purge -y --autoremove ${packages_remove[@]}
    sudo nala upgrade -y
    sudo nala install -y ${packages[@]}
    sudo nala clean

    # Configure firewall
    echo "Configuring firewall..."

    sudo ufw default deny incoming  # Default Rules
    sudo ufw default allow outgoing

    sudo ufw allow 80/tcp   # HTTP / HTTPS
    sudo ufw allow 443/tcp

    sudo ufw limit 22/tcp   # SSH

    sudo ufw allow 42000    # Warpinator
    sudo ufw allow 42001

    sudo ufw enable

    if [[ "$set_governor" == true ]]; then
        # Check current cpu governor
        # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

        sudo apt-get install -y linux-cpupower
        
        sudo cp $LOC/res/cpupower.service /etc/systemd/system
        sudo sed -i "s/cpu_governor/$cpu_governor/g" /etc/systemd/system/cpupower.service

        sudo systemctl enable --now cpupower.service
    fi

    ;;

esac

# General configuration

# Install Rust
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y --no-modify-path

# Configure Flatpak
if [[ " ${packages[*]} " =~ " flatpak " ]]; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub -y ${flatpaks[@]}

    # Firefox/Librewolf flatpak workaround for some fonts. It's fixed on debian testing (trixie). Github issue: https://github.com/flatpak/flatpak/issues/4571
    mkdir -p ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d
    rm -rf ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d/*
    cp /etc/fonts/conf.d/*.conf ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d
fi

# Configuration files
cp -r $LOC/config/bash/.bashrc.d ~/

if [[ "$auto_restore_backup" == true ]]; then
    chmod a+x $LOC/backup.sh
    $LOC/backup.sh restore
else
    echo "Do you want to restore the backup now?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) $LOC/backup.sh restore; break;;
            No ) break;;
        esac
    done
fi

echo "Setup Completed!"
