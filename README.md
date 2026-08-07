# Volumio Surface Dial

Use a Microsoft Surface Dial as a tactile Bluetooth controller for Volumio.

> **Project status:** experimental / hardware validation required. The plugin is designed for the current Volumio plugin framework, including Volumio 4, but v0.1.0 should not yet be treated as a production-stable release until the hardware checklist in `docs/TESTING.md` has been completed on a real Surface Dial.

## Features

- Single Volumio plugin installation; no separate application or daemon for the user to install.
- Bluetooth discovery, pairing and removal from the plugin settings page using BlueZ.
- Direct Microsoft Surface Dial input through Linux `hidraw`.
- Automatic reconnect after sleep, Bluetooth drop-out or reboot.
- Clockwise / anticlockwise rotation mapped to Volumio volume.
- Configurable volume step and rotation direction.
- Configurable single-, double- and long-press actions.
- Experimental confirmation haptic after button actions.
- Architecture-neutral JavaScript implementation with no compiled Node modules.

## Default controls

| Surface Dial input | Default action |
| --- | --- |
| Rotate clockwise | Volume +2% |
| Rotate anticlockwise | Volume -2% |
| Single press | Play / pause |
| Double press | Next track |
| Long press | Previous track |

## Requirements

- Volumio 3 or 4 using the standard plugin framework.
- A host with working Bluetooth hardware supported by Linux / BlueZ.
- Microsoft Surface Dial (USB VID `045e`, PID `091b`).
- SSH access is currently required to install this development build from GitHub. Once accepted into the Volumio plugin store, normal users should be able to install it from the Volumio UI.

The plugin's installer checks for `bluetoothctl` and installs the `bluez` package if it is missing. It also installs a narrowly scoped udev rule so the Volumio service user can access this Surface Dial's `hidraw` device.

## Install from GitHub

Enable SSH in Volumio, connect to the player, then run:

```sh
cd /home/volumio
git clone https://github.com/jhscann/volumio-surface-dial.git
cd volumio-surface-dial
volumio plugin install
volumio vrestart
```

When Volumio has restarted:

1. Open **Settings → Plugins → Installed Plugins**.
2. Find **Surface Dial** under **System Hardware**.
3. Enable the plugin.
4. Open its settings page and pair the Dial.

For later updates from GitHub:

```sh
cd /home/volumio/volumio-surface-dial
git pull
volumio plugin install
volumio vrestart
```

## Pair the Surface Dial

1. Hold the pairing button on the underside of the Surface Dial until its LED flashes.
2. Open **Surface Dial** plugin settings.
3. Select **Scan for Surface Dial**.
4. The plugin saves the first discovered device named Surface Dial.
5. Re-open the settings page if needed so the discovered Bluetooth address appears.
6. Select **Pair selected Surface Dial**.
7. The plugin will then look for the corresponding `hidraw` endpoint and reconnect automatically when it becomes available.

See `docs/CONFIGURATION.md` for every setting and its meaning.

## Configuration fields

| Setting | Default | Description |
| --- | ---: | --- |
| Surface Dial Bluetooth address | blank | MAC address selected by Scan; may also be entered manually. |
| Volume change per detent | 2% | Volumio volume adjustment for each Dial rotation event; constrained internally to 1–20%. |
| Reverse rotation direction | Off | Swaps clockwise and anticlockwise volume behaviour. |
| Single press | Play / Pause | Action after one short click. |
| Double press | Next track | Action after two short clicks within the configured window. |
| Long press | Previous track | Action after holding the Dial for the configured threshold. |
| Experimental confirmation haptic | Off | Attempts a basic Surface Dial output report after a button action. |
| Double-press window | 420 ms | Maximum interval used to distinguish a double press from a single press. |
| Long-press threshold | 700 ms | Minimum hold time treated as a long press. |
| Reconnect interval | 5 s | Delay between attempts to locate the Dial's `hidraw` device. |

Available press actions are **Play / Pause**, **Next track**, **Previous track**, and **Do nothing**.

## How it works

```text
Surface Dial
    │
    │ Bluetooth HID
    ▼
Linux BlueZ / HID subsystem
    │
    ▼
/dev/hidraw*
    │
    ▼
Volumio Surface Dial plugin
    ├─ parses rotation and button reports
    ├─ recognises single / double / long press
    ├─ reconnects when the Dial reappears
    └─ sends Volumio playback / volume commands
```

The plugin reads `hidraw` directly from the Volumio Node process. There is no separate permanent daemon and no architecture-specific helper binary.

## Surface Dial protocol used

The current implementation handles the basic input report observed by the open-source Surface Dial projects:

- report ID `0x01`
- bit 0 of byte 1: button pressed / released
- byte 2 `0x01`: clockwise rotation
- byte 2 `0xff`: anticlockwise rotation

A basic manual haptic output report is implemented experimentally. Programmable detent count and automatic haptic behaviour require HID feature-report handling and are intentionally deferred until basic hardware behaviour has been validated on Volumio 4.

## Permissions and security

`install.sh` creates `/etc/udev/rules.d/99-volumio-surface-dial.rules`. The rule applies only to the Microsoft Surface Dial identifiers used by this plugin and grants the `volumio` group access to the corresponding `hidraw` device. `uninstall.sh` removes the rule.

The plugin does not modify `/volumio` or `/myvolumio`. Bluetooth commands are executed through `/usr/bin/bluetoothctl`; Volumio playback commands are executed through `/usr/local/bin/volumio` with fixed, plugin-generated arguments.

See `SECURITY.md` for reporting security issues.

## Troubleshooting

See `docs/TROUBLESHOOTING.md`. Useful first checks are:

```sh
bluetoothctl devices
bluetoothctl info <MAC>
ls -l /dev/hidraw*
cat /sys/class/hidraw/hidrawX/device/uevent
journalctl -u volumio -f
```

## Development and testing

Run the unit tests with:

```sh
npm test
```

They currently cover Surface Dial HID report parsing and Bluetooth device-list parsing. Hardware validation steps are in `docs/TESTING.md`.

## Known limitations

- v0.1.0 has not yet completed a real Surface Dial + current Volumio 4 hardware validation pass.
- Bluetooth discovery output can vary slightly between BlueZ releases and may require adjustment after wider testing.
- Programmable haptic detents are not yet implemented.
- Battery level is not exposed.
- Rotation currently controls volume only; a secondary seek/navigation mode is not yet implemented.
- The settings page currently selects the first discovered device whose Bluetooth name matches `Surface Dial`.

## Contributing

Bug reports, hardware test results and pull requests are welcome. Please read `CONTRIBUTING.md` before submitting changes.

## Acknowledgements

Protocol research was informed by:

- [andreasjhkarlsson/mac-dial](https://github.com/andreasjhkarlsson/mac-dial), which demonstrated direct Surface Dial HID handling on macOS.
- Daniel Prilik's Surface Dial Linux haptics work, referenced by `mac-dial`.

This repository is an independent implementation and does not copy source code from those projects.

Microsoft, Surface and Surface Dial are trademarks of Microsoft Corporation. This project is unofficial and is not affiliated with or endorsed by Microsoft or Volumio.

## Licence

MIT — see `LICENSE`.
