#!/usr/bin/env bash

distros=(
    debian
)

# Common options
DE="gnome"

set_governor="true"
cpu_governor="powersave"

flatpaks=(  # Requires flatpak to be installed (make sure to include it in your packages list)
    cc.arduino.IDE2
    com.github.tchx84.Flatseal
    com.usebottles.bottles
    io.github.shiftey.Desktop
    io.gitlab.librewolf-community
    io.mpv.Mpv
    org.gimp.GIMP
    org.gnome.SimpleScan
    org.keepassxc.KeePassXC
    org.libreoffice.LibreOffice
    org.localsend.localsend_app
    org.qbittorrent.qBittorrent

    com.discordapp.Discord
)

auto_restore_backup=false
dotconfig_dirs=(    # directories to backup
    gh
)

case $distro in

"debian")

    packages=(
        adb fastboot
        autojump
        bat
        codium
        curl
        ffmpeg
        flatpak
        gh
        git
        jpegoptim optipng
        latexmk
        lm-sensors
        mingw-w64
        net-tools
        nmap
        nodejs npm
        plocate
        podman
        python3 python3-venv python-is-python3 pypy3
        rsync
        tldr
        trash-cli
        ufw
        qemu-system virt-manager
        wine
    )
    packages_remove=()

    case $DE in

    "gnome")

        packages+=(
            ffmpegthumbnailer   # Replacement for totem-video-thumbnailer
            gnome-software-plugin-flatpak
        )

        packages_remove+=(
            firefox-esr
            libreoffice-common
            synaptic
            transmission-common

            baobab
            cheese
            eog
            #evince
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
            org.gnome.Snapshot
        )
        ;;

    esac
    ;;

esac
