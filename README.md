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

3. Install couchpotato

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

```



5. Clone this project

```
# git clone https://github.com/allangarcia/seedbox-to-plex-automation.git scripts
```
