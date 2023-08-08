#!/usr/bin/env bash

distros=(
    debian
)

# Common options
DE="gnome"

set_governor="true"
cpu_governor="powersave"

use_flatpak=true    # Requires flatpak to be installed
flatpaks=(
    cc.arduino.IDE2
    com.github.tchx84.Flatseal
    com.vscodium.codium
    io.github.shiftey.Desktop
    io.gitlab.librewolf-community
    io.mpv.Mpv
    org.gimp.GIMP
    org.gnome.SimpleScan
    org.keepassxc.KeePassXC
    org.libreoffice.LibreOffice
    org.qbittorrent.qBittorrent
    org.x.Warpinator
)

restore_backup=true
dotconfig_dirs=(    # directories to backup
    gh
)

# Debian-specific options
deb_packages=(
    android-sdk-platform-tools
    autojump
    curl
    ffmpeg
    gh
    git
    jpegoptim optipng
    lm-sensors
    net-tools
    nmap
    plocate
    python3 python3-venv python-is-python3 pypy3
    rsync
    trash-cli
    ufw
    qemu-system virt-manager
)
deb_packages_remove=()

case $DE in

"gnome")
    deb_packages_remove+=(
        ffmpegthumbnailer   # Replacement for totem-video-thumbnailer
    )

    deb_packages_remove+=(
        firefox-esr
        libreoffice-common
        rhythmbox
        simple-scan
        synaptic
        transmission-common

        evolution
        gnome-calendar
        gnome-clocks
        gnome-contacts
        gnome-games
        gnome-maps
        gnome-music
        gnome-sound-recorder
        gnome-weather
        shotwell
        totem
        yelp
    )
    ;;

esac
