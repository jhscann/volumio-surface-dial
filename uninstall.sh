#!/bin/bash
set -e

echo "Removing Surface Dial plugin system additions"
sudo rm -f /etc/udev/rules.d/99-volumio-surface-dial.rules
sudo udevadm control --reload-rules || true
sudo udevadm trigger --subsystem-match=hidraw || true
echo "Surface Dial plugin removed"
echo "pluginuninstallend"
