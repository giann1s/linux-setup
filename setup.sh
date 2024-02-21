#!/usr/bin/env bash

# Check current cpu governor
# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

configure_ufw () {
    echo "Configuring firewall..."

    sudo ufw default deny incoming  # Default Rules
    sudo ufw default allow outgoing

    sudo ufw allow http
    sudo ufw allow https

    sudo ufw limit ssh

    sudo ufw allow 53317    # LocalSend

    sudo ufw enable
}

# -------------------------- Start of script --------------------------

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

##### Distro-specific configuration #####

# We need this first to ensure that all the required
# packages are installed before further changes.
case $distro in

"arch")

    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm ${packages[@]}

    systemctl enable --now virtqemud

    configure_ufw

    if [[ "$set_governor" == true ]]; then
        sudo sed -i "/governor=/c governor=\"$cpu_governor\"" /etc/default/cpupower
        sudo systemctl enable --now cpupower.service
    fi

    grub_default_arch="\"Advanced options for Arch Linux>Arch Linux, with Linux linux\""
    sudo sed -i "/GRUB_DEFAULT=/c GRUB_DEFAULT=$grub_default_arch" /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg

    ;;

"debian")

    # The bat executable have been renamed from ‘bat’ to ‘batcat’
    # because of a file name clash with another Debian package,
    # so an alias is necessary to use bat with the regular command.
    mkdir -p ~/.bashrc.d
    cp $LOC/res/debian/bat.bashrc ~/.bashrc.d

    sudo apt-get update
    sudo apt-get purge -y --autoremove ${packages_remove[@]}
    sudo apt-get upgrade -y
    sudo apt-get install -y ${packages[@]}
    sudo apt-get clean

    configure_ufw

    if [[ "$set_governor" == true ]]; then
        sudo cp $LOC/res/cpupower.service /etc/systemd/system
        sudo sed -i "s/cpu_governor/$cpu_governor/g" /etc/systemd/system/cpupower.service

        sudo systemctl enable --now cpupower.service
    fi

    ;;

esac

##### General configuration #####

# .bashrc files

# Extend .bashrc to execute the rc files in ~/.bashrc.d
cp /etc/skel/.bashrc ~ && echo >> ~/.bashrc && cat $LOC/res/run_rcs.bashrc >> ~/.bashrc

cp -r $LOC/config/bash/.bashrc.d ~/
source ~/.bashrc

# File templates
cp -r $LOC/res/Templates ~/

# Install Rust
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y --no-modify-path

# .config files (not from backup)

# Alacritty
mkdir -p ~/.config/alacritty/
cp $LOC/config/alacritty.toml ~/.config/alacritty/

# Configure Flatpak
if [[ " ${packages[*]} " =~ " flatpak " ]]; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub -y ${flatpaks[@]}

    # VSCodium
    cp $LOC/config/vscodium.json ~/.var/app/com.vscodium.codium/config/VSCodium/User/settings.json
    flatpak --user override com.vscodium.codium --env=PATH=/app/bin:/usr/bin:/home/$USER/.cargo/bin

    if [[ "$distro" == "debian" ]]; then
        # Firefox/Librewolf flatpak workaround for some fonts. It's fixed on debian testing (trixie). Github issue: https://github.com/flatpak/flatpak/issues/4571
        mkdir -p ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d
        rm -rf ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d/*
        cp /etc/fonts/conf.d/*.conf ~/.var/app/io.gitlab.librewolf-community/config/fontconfig/conf.d
    fi
fi

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
