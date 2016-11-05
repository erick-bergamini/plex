# seedbox-to-plex-automation
Collection of bash scripts to automate my plexmediaserver

# How did I installed my plexmediaserver? (STILL INCOMPLETE)

## Hardware

- I'm using a Raspberry Pi 3 Model B (https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) with an attached Seagate External Drive 2TB

## Operational System

- I'm using a NOOBs (https://www.raspberrypi.org/downloads/noobs/) version installer for Raspbian (all default install)

## Packages

1. After Raspbian install I did a full update as always

```
$ sudo apt-get update && sudo apt-get upgrade -y
$ sudo apt-get update && sudo apt-get dist-upgrade
```

2. Added a PMS repository with those commands

```
$ sudo apt-get install apt-transport-https -y --force-yes
$ wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -
$ echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list
$ sudo apt-get update
$ sudo apt-get install -t jessie plexmediaserver -y
```

3. Then I installed my seedbox packages

```
$ sudo apt-get install deluged deluge-console deluge-web
```

4. Then I installed aditional packages

```
$ sudo apt-get install youtube-dl oracle-java8-jdk vim htop rsync
```

