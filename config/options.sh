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

case $distro in

"debian")

    packages=(
        android-sdk-platform-tools
        autojump
        bat
        codium
        curl
        ffmpeg
        gh
        git
        jpegoptim optipng
        lm-sensors
        nala
        net-tools
        nmap
        nodejs npm
        plocate
        python3 python3-venv python-is-python3 pypy3
        rsync
        tldr
        trash-cli
        ufw
        qemu-system virt-manager
    )
    packages_remove=()

    case $DE in

    "gnome")

        packages+=(
            ffmpegthumbnailer   # Replacement for totem-video-thumbnailer
        )

        packages_remove+=(
            firefox-esr
            libreoffice-common
            synaptic
            transmission-common

            baobab
            eog
            evince
            evolution
            #file-roller
            gnome-calendar
            gnome-characters
            gnome-clocks
            gnome-contacts
            gnome-font-viewer
            gnome-games
            gnome-logs
            gnome-maps
            gnome-music
            #gnome-shell-extension-prefs
            gnome-sound-recorder
            #gnome-text-editor
            gnome-weather
            rhythmbox
            seahorse
            shotwell
            simple-scan
            totem
            yelp
        )

        flatpaks+=(
            org.gnome.Loupe
        )
        ;;

    esac
    ;;

esac
