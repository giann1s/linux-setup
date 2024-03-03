## Usage

Clone the repo and make the scripts executable:

    git clone https://github.com/giann1s/linux-setup.git &&
    cd ./linux-setup && chmod a+x setup.sh & chmod a+x backup.sh

then launch the script by running:

    bash ./setup.sh <name_of_distro>

### Backup
To make a backup of your apps (including flatpaks) execute the backup.sh script which stores the data in /config/app-data.

    bash ./backup.sh

To restore/delete the backup pass the `restore` or `delete` argument accordingly to backup.sh.

    bash ./backup.sh restore
    bash ./backup.sh delete

Note: If the `auto_restore_backup` option is enabled in the /config/options.sh file, the data will be automatically restored upon running the setup.sh script.

## My Configuration

### VSCodium Extensions

- Live Preview
- C/C++ Themes
- Language Support for Java(TM) by Red Hat
- Python, Pylint, Mypy Type Checker, isort
- Prettier - Code formatter
- rust-analyzer
- Even Better TOML

- Compare Folders

- LaTeX Workshop

- Code Spell Checker
- Greek - Code Spell Checker
