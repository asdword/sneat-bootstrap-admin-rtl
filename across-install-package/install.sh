#!/bin/bash

killall -9 AcrossCenter > /dev/null 2>&1
systemctl stop acrossd > /dev/null 2>&1
rm -rf /usr/local/bin/across > /dev/null 2>&1
rm /etc/xdg/autostart/AcrossCenter.desktop > /dev/null 2>&1

cp -n /etc/hosts /etc/hosts.across.bak

mv -f ./across /usr/local/bin
chown -R root:root /usr/local/bin/across

mv -f ./acrossd.service /etc/systemd/system
chown root:root /etc/systemd/system/acrossd.service

mkdir /etc/across > /dev/null 2>&1
mv -f ./openssl.cnf /etc/across
chown root:root /etc/across/openssl.cnf

mv -f ./com.clixon.across.policy /usr/share/polkit-1/actions
chown root:root /usr/share/polkit-1/actions/com.clixon.across.policy

mv -f ./across-Across.png /usr/share/icons
chown root:root /usr/share/icons/across-Across.png

/usr/local/bin/across/acrossd -init_license

systemctl daemon-reload

cd ..
rm -rf ./across-install-package

echo "Across Install Done. Now, run /usr/local/bin/across/AcrossCenter."
