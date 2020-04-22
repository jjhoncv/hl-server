#!/bin/bash
apt update -y

dpkg --add-architecture i386

apt update -y

apt-get install -y wine32 unzip resolvconf

echo "[wine instalado]"

wine --version

# install half life
cd /root
mkdir hl 
cd hl
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1T-4dpmfeS6gWq90iZU7fssWXAha47_L-' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1T-4dpmfeS6gWq90iZU7fssWXAha47_L-" -O hl.tar.xz && rm -rf /tmp/cookies.txt
tar xvf hl.tar.xz 
rm -fr hl.tar.xz

cd /root/hl-server
# install podbot
unzip addons/podbot_full_v3b21.zip -d /root/hl/cstrike/addons
cp -rf wptdefault/* /root/hl/cstrike/addons/podbot/wptdefault/
echo 'cs_mansion' >> /root/hl/cstrike/addons/amxmodx/configs/maps.ini
cp -rf addons/podbot.cfg /root/hl/cstrike/addons/podbot/podbot.cfg

# config plugins
cp -rf plugins.ini /root/hl/cstrike/addons/metamod/plugins.ini 

# config server
cp -rf server.cfg /root/hl/cstrike/server.cfg

echo 'config password default 123'

cp -rf autoexec.cfg /root/hl/cstrike/autoexec.cfg

echo 'nameserver 1.1.1.1
nameserver 8.8.8.8' >> /etc/resolvconf/resolv.conf.d/head

cp rc-local.service /etc/systemd/system/rc-local.service

systemctl enable rc-local

cp .bash_aliases /root/.bash_aliases

reboot