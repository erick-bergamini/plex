# seedbox-to-plex-automation
Collection of bash scripts to automate my plexmediaserver

# How did I installed my Plex on Raspberry Pi 3?

## This is my hardware

- I'm using a Raspberry Pi 3 Model B (https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
- You'll probably want an attached storage or a network one to store your media files

## I choose the easy one for the Operational System

- I'm using a NOOBs Lite version installer (https://www.raspberrypi.org/downloads/noobs/) and doing a Raspbian Lite (minimal) install
- Default user "pi", default password "raspberry"

## Configure your stuff

- Change your passwords and add your users
- Configure any aditional interfaces, wired is always preferred.
- Configure your hostname

```
# hostname-ctl set-hostname plex
```

- Edit your /etc/hosts accordingly
- Configure your timezone

```
# dpkg-reconfigure tzdata
```

## Beginning the installation

1. After Raspbian Lite install I did a full update as always

```
# apt update
# apt upgrade
# apt dist-upgrade
```

2. Added a PMS repository and installed with those commands

```
# wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add -
# echo "deb https://dev2day.de/pms/ jessie main" | tee /etc/apt/sources.list.d/pms.list
# apt update
# apt install -t jessie plexmediaserver
```

3. Then I installed my seedbox packages

```
# apt install deluged deluge-console deluge-web
# sed -i "s/ENABLE_DELUGED=0/ENABLE_DELUGED=1/" /etc/default/deluged
# service deluged start
# echo "deluged:deluged:10" >> /var/lib/deluged/config/auth 
```

No init script is provided for __deluge-web__ package unfortunately, so install mine. ;-D

```
# cd /etc/systemd/system/
# wget https://gist.github.com/allangarcia/146e8db29e5d45766aee16043e7fb347/raw/fce670ac72db3957029d4e1c02ae8603c4156abc/deluge-web.service
# systemctl enable deluge-web
# systemctl start deluge-web
# systemctl status deluge-web
```

4. Then I installed aditional packages

```
# apt install oracle-java8-jdk git vim htop
```

## Download the raw stuff

1. Install all your stuff on /opt

```
# cd /opt
```

2. Install filebot

```
# mkdir -p /opt/filebot
# cd /opt/filebot
# wget https://github.com/filebot/filebot/raw/master/installer/portable/update-filebot.sh
# wget https://github.com/filebot/filebot/raw/master/installer/portable/filebot.sh
# chmod +x update-filebot.sh
# chmod +x filebot.sh
# /opt/filebot/update-filebot.sh
# /opt/filebot/filebot.sh
```

3. Install sickrage

```
# cd /opt
# addgroup --system sickrage
# adduser --disabled-password --system --home /var/lib/sickrage --gecos "SickRage" --ingroup sickrage sickrage
# git clone https://github.com/SickRage/SickRage.git sickrage
# chown sickrage:sickrage /opt/sickrage
# cp /opt/sickrage/runscripts/init.debian /etc/init.d/sickrage
# chown root:root /etc/init.d/sickrage
# chmod 755 /etc/init.d/sickrage
# update-rc.d sickrage defaults
# mkdir -p /var/run/sickrage
# chown sickrage:sickrage /var/run/sickrage
# service sickrage start
```

4. Install couchpotato

```
# cd /opt
# addgroup --system couchpotato
# adduser --disabled-password --system --home /var/lib/couchpotato --gecos "CouchPotato" --ingroup couchpotato couchpotato
# git clone https://github.com/CouchPotato/CouchPotatoServer.git couchpotato
# chown couchpotato:couchpotato /opt/couchpotato
# cp couchpotato/init/ubuntu /etc/init.d/couchpotato
# chown root:root /etc/init.d/couchpotato
# chmod 755 /etc/init.d/couchpotato
# update-rc.d couchpotato defaults
# mkdir -p /var/run/couchpotato
# chown couchpotato:couchpotato /var/run/couchpotato
# service couchpotato start
```

5. Clone this project

```
# cd /opt
# git clone https://github.com/allangarcia/seedbox-to-plex-automation.git scripts
```

## Mount your external media

1. Make your mountpoint

```
# mkdir -p /mnt/media
```

2. Plug your device, wipe the partition table, make a new partition and filesystem

**PS: DON'T DO THIS IF YOU ALREADY HAVE MEDIA FILES, DON'T BE STUPID!!!**

```
# fdisk /dev/sda
# mkfs.ext4 /dev/sda1
```

3. Get the UUID of your new partition, and write down (CTRL+C!) the UUID= part

```
# blkid /dev/sda1
```

```
/dev/sda1: UUID="a01e4f27-1f10-42dc-bf94-a4e48d7b9bfe" TYPE="ext4" PARTUUID="5850a332-01"
```

4. Download the mount file for systemd and enable it

```
# cd /etc/systemd/system
# wget https://gist.github.com/allangarcia/203e7d57e5e213b54f73509c24e089df/raw/f5b7ee4b3d4765353f1d26ffd040083837c77f0f/mnt-media.mount
```

5. Edit this file and change the UUID part for your UUID copied previously

```
# sed -i "s/by-uuid\/.*/by-uuid\/YOUR-UUID-GOES-HERE/" mnt-media.mount
```

6. Reload systemd daemon, enable the service and start it

```
# systemctl daemon-reload
# systemctl start mnt-media.mount
# systemctl status mnt-media.mount
# systemctl enable mnt-media.mount
```

## Configuration

```
Still in development.
```
