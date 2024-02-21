upgrade () {
    if apt-get --version &> /dev/null; then
        sudo apt-get update && \
        sudo apt-get upgrade --assume-yes && \
        sudo apt-get autoremove --purge --assume-yes
    fi && \

    if pacman --version &> /dev/null; then
        sudo pacman -Syu --noconfirm && \

        if [[ $(pacman -Qqdt | head -c1 | wc -c) -ne 0 ]]; then
            sudo pacman -R $(pacman -Qdtq) --noconfirm
        fi
    fi && \

    if flatpak --version &> /dev/null; then
        flatpak upgrade --assumeyes
    fi
}
