# Hardware test checklist

Version 0.2.0 has been developed against a real Microsoft Surface Dial and Volumio 4. Run this checklist on each target hardware/architecture before requesting stable Plugin Store promotion.

## Installation and lifecycle
- `volumio plugin install` completes with `plugininstallend`.
- Plugin appears under **System Hardware** and can be enabled and disabled normally.
- Enabling produces no `does not return adequate promise` lifecycle warnings.
- Disabling stops HID reads and reconnect timers without requiring a reboot.
- `/etc/udev/rules.d/99-volumio-surface-dial.rules` is created with the plugin ownership marker.
- The installer refuses to overwrite an unrelated pre-existing file at that path.
- UI uninstall completes with `pluginuninstallend` and removes the plugin-owned udev rule.
- Uninstall does not remove shared BlueZ or Python packages or disable Bluetooth globally.

## Bluetooth
- Scan finds a Dial while its underside pairing button is held.
- Pair completes using the BlueZ `NoInputNoOutput` agent.
- `bluetoothctl info <MAC>` shows Paired/Trusted/Connected.
- A Surface Dial `/dev/hidraw*` node appears.
- After the Dial sleeps, pressing or rotating it allows the plugin to reconnect automatically without opening Settings or pairing again.
- Reconnect also succeeds after a Volumio reboot.

## Volume and haptics
- With Haptics on, one complete revolution has 50 tactile detents.
- Each clockwise detent increases volume by exactly 2 percentage points until 100%.
- Each anticlockwise detent decreases volume by exactly 2 percentage points until 0%.
- One complete revolution therefore represents 100 volume percentage points.
- Reverse direction works.
- With Haptics off, rotational and button-action haptic feedback are disabled.
- Re-enabling Haptics reprograms the connected Dial without requiring re-pairing.
- Rapid rotation remains predictable and does not stall Volumio or flood logs.

## Buttons
- Single press defaults to Play / Pause.
- Double press defaults to Next track and does not also fire the single-press action.
- Long press defaults to Previous track and does not also fire a short-press action.
- All press actions can be changed to Play / Pause, Next, Previous or Do nothing.

## Packaging
- `npm test` passes.
- `volumio plugin package` succeeds.
- The generated plugin archive is below the Volumio submission size limit.
- A fresh install from the generated package behaves identically to a development checkout install.

## Diagnostics
```sh
bluetoothctl info <MAC>
ls -l /dev/hidraw*
udevadm info --attribute-walk --name=/dev/hidrawX
cat /sys/class/hidraw/hidrawX/device/uevent
journalctl -u volumio -f
```
