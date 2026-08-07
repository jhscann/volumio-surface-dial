#!/bin/bash
set -e

echo "Installing Surface Dial plugin prerequisites"
if ! command -v bluetoothctl >/dev/null 2>&1; then
  echo "Installing BlueZ Bluetooth utilities"
  sudo apt-get update
  sudo apt-get -y install bluez --no-install-recommends
fi
RULE_FILE="/etc/udev/rules.d/99-volumio-surface-dial.rules"
sudo tee "$RULE_FILE" >/dev/null <<'RULES'
# Surface Dial over USB-style HID parent (where exposed)
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="091b", MODE:="0660", GROUP:="volumio"
# Surface Dial over Bluetooth HID/UHID
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="*045E:091B*", MODE:="0660", GROUP:="volumio"
RULES
sudo udevadm control --reload-rules || true
sudo udevadm trigger --subsystem-match=hidraw || true
sudo systemctl enable bluetooth.service >/dev/null 2>&1 || true
sudo systemctl start bluetooth.service >/dev/null 2>&1 || true
echo "Surface Dial plugin installed"
echo "plugininstallend"
