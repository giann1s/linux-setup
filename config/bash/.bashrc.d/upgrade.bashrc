upgrade () {
    if apt-get --version &> /dev/null; then
        sudo apt-get update && \
        sudo apt-get upgrade --assume-yes && \
        sudo apt-get autoremove --purge --assume-yes
    fi && \

    if flatpak --version &> /dev/null; then
        flatpak upgrade --assumeyes
    fi
}
