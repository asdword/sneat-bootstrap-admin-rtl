#!/bin/bash

killall -9 AcrossCenter

systemctl stop acrossd
systemctl disable acrossd

if [ "$1" == "-f" ]; then
  sed -i -- 's/Type.*=.*$/Type=oneshot/g' /etc/systemd/system/acrossd.service
  sed -i -- 's/Restart.*=.*$//g' /etc/systemd/system/acrossd.service
  sed -i -- 's/RestartSec.*=.*$//g' /etc/systemd/system/acrossd.service
  sed -i -- 's/ExecStart.*=.*$/ExecStart=\/usr\/local\/bin\/across\/acrossd -rc/g' /etc/systemd/system/acrossd.service
  systemctl daemon-reload
  systemctl start acrossd

  rm -rf /etc/across
  rm -rf /var/lib/across
  rm -rf /var/run/AcrossHome
  rm /var/run/acrossd.pid
  rm -rf /home/*/.config/across
fi

rm /etc/systemd/system/acrossd.service
systemctl daemon-reload

rm /etc/xdg/autostart/AcrossCenter.desktop

rm /usr/share/polkit-1/actions/com.clixon.across.policy

rm /usr/share/icons/across-Across.png

rm -rf /usr/local/bin/across

echo "Across Remove Done."
