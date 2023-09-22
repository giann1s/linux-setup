## Usage

Clone the repo and make the scripts executable:

    git clone https://github.com/Giann1s/linux-setup.git &&
    cd ./linux-setup && chmod a+x setup.sh & chmod a+x backup.sh

then launch the script by running:

    bash ./setup.sh <name of distro>

### Backup
To make a backup of your apps (including flatpaks) execute the backup.sh script which stores the data in /config/app-data.

    bash ./backup.sh

To restore/delete the backup pass the `restore` or `delete` argument accordingly to backup.sh.

    bash ./backup.sh restore
    bash ./backup.sh delete

Note: If the `auto_restore_backup` option is enabled in the /config/options.sh file, the data will be automatically restored upon running the setup.sh script.
