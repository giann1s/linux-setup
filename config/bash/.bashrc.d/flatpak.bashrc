# Check if flatpak is installed
flatpak --version &> /dev/null || return

# flatpak creates symlinks of apps in /var/lib/flatpak/exports/bin/
# for user-specific apps (installed with --user) they are located in ~/.local/share/flatpak/exports/bin
PATH="/var/lib/flatpak/exports/bin:$PATH"

declare -A id_catalog=(
    [cc.arduino.IDE2]=arduino
    [com.github.tchx84.Flatseal]=flatseal
    [com.obsproject.Studio]=obs
    [com.vscodium.codium]=codium
    [fr.handbrake.ghb]=handbrake
    [io.mpv.Mpv]=mpv
    [io.github.shiftey.Desktop]=github
    [io.gitlab.librewolf-community]=librewolf
    [org.gimp.GIMP]=gimp
    [org.gnome.SimpleScan]=simple-scan
    [org.jellyfin.JellyfinServer]=jellyfin
    [org.keepassxc.KeePassXC]=keepassxc
    [org.libreoffice.LibreOffice]=libreoffice
    [org.mozilla.firefox]=firefox
    [org.qbittorrent.qBittorrent]=qbittorrent
    [org.texstudio.TeXstudio]=texstudio
    [org.x.Warpinator]=warpinator
)

for id in $(ls /var/lib/flatpak/exports/bin); do
    if [[ ${id_catalog[$id]} ]] then
        alias ${id_catalog[$id]}=$id
    fi
done
