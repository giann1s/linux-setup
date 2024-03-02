# Check if flatpak is installed
flatpak --version &> /dev/null || return

declare -A id_catalog=(
    [cc.arduino.IDE2]=arduino
    [com.github.tchx84.Flatseal]=flatseal
    [com.obsproject.Studio]=obs
    [com.usebottles.bottles]=bottles
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
    [org.localsend.localsend_app]=localsend
    [org.mozilla.firefox]=firefox
    [org.qbittorrent.qBittorrent]=qbittorrent
    [org.texstudio.TeXstudio]=texstudio

    # Gnome
    [io.github.celluloid_player.Celluloid]=celluloid
    [io.gitlab.news_flash.NewsFlash]=newsflash
    [org.gnome.Evince]=evince
    [org.gnome.FileRoller]=file-roller
    [org.gnome.Fractal]=fractal
    [org.gnome.Geary]=geary
    [org.gnome.Loupe]=loupe
    [org.gnome.Snapshot]=snapshot
    [org.gnome.TextEditor]=gnome-text-editor

    [com.discordapp.Discord]=discord
)

for id in $(ls /var/lib/flatpak/exports/bin); do
    if [[ ${id_catalog[$id]} ]]; then
        alias ${id_catalog[$id]}="flatpak run $id"
    fi
done
