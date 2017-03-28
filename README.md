# seedbox-to-plex-automation
Collection of bash scripts to automate my plexmediaserver

# How did I installed my Plex on Raspberry Pi 3?

## This is my hardware

- I'm using a Raspberry Pi 3 Model B (https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
- You'll probably want an attached storage or a network one to store your media files

## I choose the easy one for Operational System

- I'm using a NOOBs Lite version installer (https://www.raspberrypi.org/downloads/noobs/) and doing a Raspbian Lite (minimal) install
- Default user "pi", default password "raspberry"

## Configure your stuff

- Change your passwords, add your users
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
# apt install git oracle-java8-jdk vim htop
```

## Download the raw stuff

1. Install all your stuff on /opt

2. Clone sickrage project

```
# git clone https://github.com/SickRage/SickRage.git sickrage
```

3. Clone couchpotato project

```
# git clone https://github.com/CouchPotato/CouchPotatoServer.git couchpotato
```

