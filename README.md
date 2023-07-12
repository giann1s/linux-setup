## Usage

Clone the repo and make the scripts executable:

    git clone https://github.com/Giann1s/linux-setup.git &&
    cd ./linux-setup && chmod a+x setup.sh & chmod a+x backup.sh

then launch the script by running:

    bash ./setup.sh <name of distro>

### Backup
To make a backup of your apps (including flatpaks) execute the backup.sh script which stores the data in /config/app-data.

    bash ./backup.sh

To delete the backup pass the `delete` argument to backup.sh.

    bash ./backup.sh delete

If the `restore_backup` option in /config/options.sh is enabled the data will be restored when the setup.sh is run or you can disable it and copy the files manually.

*\* Make sure to modify the script according to your own configuration.*
