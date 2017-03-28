# seedbox-to-plex-automation
Collection of bash scripts to automate my plexmediaserver

# How did I installed my plexmediaserver? (STILL INCOMPLETE)

## Hardware

- I'm using a Raspberry Pi 3 Model B (https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
- You'll probably want an attached storage of a network one to store your media files

## Operational System

- I'm using a NOOBs Lite version installer (https://www.raspberrypi.org/downloads/noobs/) and doing a Raspbian Lite (minimal) install
- Default user "pi", default password "raspberry"

## Configure your network

- Configure any aditional interfaces, wired is always preferred.
- Configure your hostname

```
# hostname-ctl set-hostname plex
```

- Edit your /etc/hosts accordingly

## Packages

1. After Raspbian Lite install I did a full update as always

```
# apt update
# apt upgrade
# apt dist-upgrade
```

2. Added a PMS repository with those commands

```
# wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add -
# echo "deb https://dev2day.de/pms/ jessie main" | tee /etc/apt/sources.list.d/pms.list
# apt update
# apt install -t jessie plexmediaserver
```

3. Then I installed my seedbox packages

```
# apt-get install --no-install-recommends deluged deluge-console deluge-web
```

4. Then I installed aditional packages

```
# apt install git oracle-java8-jdk vim htop rsync
```

