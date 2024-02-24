#!/usr/bin/env bash

distros=(
    arch
    debian
)

# Common options
DE="gnome"

set_governor="true"
cpu_governor="powersave"

auto_restore_backup=false
dotconfig_dirs=(    # directories to backup
    gh
)

flatpaks=(  # Requires flatpak to be installed (make sure to include it in your packages list)
    cc.arduino.IDE2
    com.github.tchx84.Flatseal
    com.usebottles.bottles
    com.vscodium.codium
    io.github.shiftey.Desktop
    io.gitlab.librewolf-community
    org.gimp.GIMP
    org.gnome.SimpleScan
    org.keepassxc.KeePassXC
    org.libreoffice.LibreOffice
    org.localsend.localsend_app
    org.qbittorrent.qBittorrent

    com.discordapp.Discord
)

case $DE in

"gnome")
    flatpaks+=(
        org.gnome.Geary
        io.github.celluloid_player.Celluloid
        io.gitlab.news_flash.NewsFlash

        org.gnome.Loupe
        org.gnome.Snapshot
    )
    ;;

esac

case $distro in

"debian")

    packages=(
        adb fastboot
        alacritty
        bat
        curl
        ffmpeg
        flatpak
        gh
        git
        jpegoptim optipng
        texlive-latex-base texlive-latex-recommended texlive-fonts-recommended latexmk texlive-lang-greek
        less
        linux-cpupower
        lm-sensors
        mingw-w64
        net-tools
        nmap
        nodejs npm
        plocate
        podman
        python3 python3-venv python-is-python3 pypy3
        qemu-system-x86 virt-manager
        rsync
        smartmontools
        tldr
        trash-cli
        ufw
        wine
        zoxide
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
            cheese
            eog
            #evince
            evolution
            #file-roller
            #gnome-backgrounds
            gnome-calendar
            gnome-characters
            gnome-clocks
            gnome-contacts
            #gnome-control-center
            #gnome-disk-utility
            gnome-font-viewer
            gnome-games
            gnome-logs
            gnome-maps
            gnome-music
            gnome-shell-extensions  # Default extensions
            #gnome-shell-extension-prefs # Tool to manage extensions
            gnome-sound-recorder
            gnome-terminal
            #gnome-text-editor
            gnome-weather
            #nautilus
            rhythmbox
            seahorse
            shotwell
            simple-scan
            totem
            yelp
        )
        ;;

    esac
    ;;

    "arch")

        packages=(
            linux-lts

            android-tools
            alacritty
            bash-completion
            bat
            cpupower
            curl
            ffmpeg
            flatpak
            github-cli
            git
            jpegoptim optipng
            texlive-basic texlive-binextra texlive-latexrecommended texlive-fontsrecommended texlive-langgreek
            less
            lm_sensors
            mingw-w64
            net-tools
            nmap
            nodejs npm
            plocate
            podman
            python3 pypy3
            qemu-system-x86 virt-manager
            rsync
            smartmontools
            tldr
            trash-cli
            ufw
            zoxide
        )
        packages_remove=()

        case $DE in

        "gnome")

            packages+=(
                evince
                file-roller
                gdm
                gnome-backgrounds
                gnome-control-center
                gnome-disk-utility
                gnome-shell
                gnome-text-editor
                gvfs-gphoto2
                gvfs-mtp
                gvfs-nfs
                gvfs-smb
                nautilus
                xdg-desktop-portal-gnome

                ffmpegthumbnailer   # Replacement for totem-video-thumbnailer
            )
            ;;

        esac
        ;;

esac
