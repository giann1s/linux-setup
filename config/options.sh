#!/usr/bin/env bash

distros=(
    debian
)

# Common
set_governor="true"
cpu_governor="powersave"

use_flatpak=true    # Requires flatpak to be installed
flatpaks=(
    cc.arduino.IDE2
    com.github.tchx84.Flatseal
    com.vscodium.codium
    io.github.shiftey.Desktop
    io.mpv.Mpv
    org.gimp.GIMP
    org.gnome.SimpleScan
    org.mozilla.firefox
    org.jellyfin.JellyfinServer
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
    gh
    git
    jpegoptim optipng
    python3 python3-pip pypy3
    rsync
    ufw
    qemu-system virt-manager
)
deb_packages_remove=(
    firefox-esr
    libreoffice-common
    rhythmbox
    simple-scan
    transmission-common

    evolution
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-sound-recorder
    gnome-weather
    shotwell
    yelp

    gnome-games
    aisleriot
    five-or-more
    four-in-a-row
    gnome-2048
    gnome-chess
    gnome-klotski
    gnome-mahjongg
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    hitori
    iagno
    lightsoff
    quadrapassel
    swell-foop
    tali
)
