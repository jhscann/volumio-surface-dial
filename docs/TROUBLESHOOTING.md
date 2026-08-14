# Troubleshooting

## Bluetooth audio stutters with Wireless Output Manager

Surface Dial sleep and reconnect activity may conflict with Bluetooth audio when Surface Dial and Wireless Output Manager use the same Bluetooth adapter. Disable the Surface Dial plugin if playback begins stuttering. Separating the Dial and speaker onto different Bluetooth adapters prevented the interruption in one Raspberry Pi/Volumio 4 test. Wireless Output Manager may still need explicit adapter selection to reconnect its speaker after reboot when the other adapter becomes BlueZ's default.

## Dial is not found
Confirm Bluetooth is active and the Dial is in pairing mode:
```sh
bluetoothctl show
bluetoothctl devices
```
Hold the underside pairing button until the LED flashes and scan again.

## Pairing fails
```sh
bluetoothctl info <MAC>
```
If an incomplete pairing exists, use **Forget Surface Dial**, return the Dial to pairing mode, scan and pair again.

## Paired but rotation does nothing
```sh
ls -l /dev/hidraw*
cat /sys/class/hidraw/hidrawX/device/uevent
```
The Surface Dial should contain Microsoft vendor `045E` and product `091B` identifiers.

Check the installed rule:
```sh
cat /etc/udev/rules.d/99-volumio-surface-dial.rules
```

## Permission denied
```sh
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=hidraw
udevadm info --attribute-walk --name=/dev/hidrawX
```

## Press actions are misclassified
Return thresholds to 420 ms double press and 700 ms long press.

## Haptics do not work
Manual haptics are experimental in v0.1.0. Disable the option if unreliable; input does not depend on haptics.

## Logs
```sh
journalctl -u volumio -f
```
Look for `[Surface Dial]` messages.

## Clean uninstall
Uninstall through Volumio. The uninstall script removes the udev rule. Use **Forget Surface Dial** first if you also want the BlueZ pairing removed.
