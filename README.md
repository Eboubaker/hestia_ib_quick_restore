Docker image with small script to restore hestia incremental backup in case server failure.

### Preparing
before the server had failed you should have had backups of your configs and keys.
1. [required] copy the restic file usually at `/usr/local/hestia/data/users/{your user}/restic.conf` to your private desktop/laptop it contains the secret key to decrypt the backup.
2. copy the rclone config file usually at `/root/.config/rclone/rclone.conf`
3. copy `/usr/local/hestia/conf/restic.conf`

> if you don't have your restic key then your backup is useless.

### Restoring incremental backup
clone the repository and replace the config files with your previosuly saved configs then build the image and start it with environment variable RESTIC_REPO and target directory.  

#### Examples
Windows Powershell
```sh
git clone https://github.com/Eboubaker/hestia_ib_quick_restore
cd hestia_ib_quick_restore
docker build . -t hestia_ib_quick_restore
docker run --rm -it -v "$PWD\restored:/backup" -e RESTIC_REPO="rclone:my_remote:/vps/admin" hestia_ib_quick_restore
```
Windows cmd
```sh
git clone https://github.com/Eboubaker/hestia_ib_quick_restore
cd hestia_ib_quick_restore
docker build . -t hestia_ib_quick_restore
docker run --rm -it -v "%cd%\restored:/backup" -e RESTIC_REPO="rclone:my_remote:/vps/admin" hestia_ib_quick_restore
```
Bash
```sh
git clone https://github.com/Eboubaker/hestia_ib_quick_restore
cd hestia_ib_quick_restore
docker build . -t hestia_ib_quick_restore
docker run --rm -it -v $(pwd)/restored:/backup -e RESTIC_REPO="rclone:my_remote:/vps/admin" hestia_ib_quick_restore
```

RESTIC_REPO can be found at `/usr/local/hestia/conf/restic.conf` but you need to append username to the path at the end for example `admin` if you are not sure then manually open the remote backup that is in google drive or mega...etc and look for the directory where the file `config` is located
