# Hardware test checklist

This release has static/unit tests but requires a real Volumio 4 + Surface Dial validation pass before a public stable release.

## Installation
- `volumio plugin install` completes with `plugininstallend`.
- Plugin appears under **System Hardware** and can be enabled/disabled.
- `/etc/udev/rules.d/99-volumio-surface-dial.rules` is created and removed on uninstall.
- Disabling the plugin stops all HID reads without requiring a reboot.

## Bluetooth
- Scan finds a Dial while its underside pairing button is held.
- Pair completes using BlueZ `NoInputNoOutput` agent.
- `bluetoothctl info <MAC>` shows Paired/Trusted/Connected.
- A Surface Dial `/dev/hidraw*` node appears.
- Plugin reconnects after the Dial sleeps/wakes and after a Volumio reboot.

## Controls
- Clockwise increases volume by configured percentage.
- Anticlockwise decreases volume.
- Reverse direction works.
- Single press toggles playback.
- Double press performs only its configured action.
- Long press performs only its configured action.
- Rapid rotation does not stall Volumio or flood logs.

## Haptics
- With experimental haptic enabled, button action attempts a confirmation pulse.
- If unreliable, leave it disabled for v0.1.x.

## Diagnostics
```sh
bluetoothctl info <MAC>
ls -l /dev/hidraw*
udevadm info --attribute-walk --name=/dev/hidrawX
cat /sys/class/hidraw/hidrawX/device/uevent
journalctl -u volumio -f
```
