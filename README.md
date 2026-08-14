# Volumio Surface Dial

Use a Microsoft Surface Dial as a tactile Bluetooth controller for Volumio 4.

Version 0.2.0 has been validated with a real Surface Dial on Volumio 4 and is being prepared for submission to the official Volumio Plugin Store. The standalone GitHub installation remains available for testing until store review is complete.

## Features

- Single Volumio plugin installation; no companion application or permanent external daemon.
- Bluetooth discovery, pairing, trust, removal and reconnect through BlueZ.
- Direct Microsoft Surface Dial input through Linux `hidraw`.
- Automatic reconnect after sleep, Bluetooth drop-out or reboot.
- Fixed, predictable volume mapping: **50 detents per revolution and 2% per detent**.
- Hardware haptic feedback for rotational detents.
- Configurable single-, double- and long-press actions.
- One **Haptics** switch controlling rotational and button-action feedback; enabled by default.
- Optional reverse rotation direction.
- Architecture-neutral JavaScript implementation with no compiled Node modules.

## Default controls

| Surface Dial input | Default action |
| --- | --- |
| Rotate clockwise | Volume +2% per detent |
| Rotate anticlockwise | Volume -2% per detent |
| Single press | Play / Pause |
| Double press | Next track |
| Long press | Previous track |

One complete revolution comprises 50 tactile detents and therefore represents 100 volume percentage points.

## Requirements

- Volumio 4 using the standard plugin framework.
- Working Bluetooth hardware supported by Linux/BlueZ.
- Microsoft Surface Dial (USB VID `045e`, PID `091b`).
- Python 3 for the bundled HID feature-report helper. The installer adds it only if it is missing.

The installer checks for `bluetoothctl` and installs BlueZ if required. It installs a narrowly scoped udev rule giving the `volumio` group access to the Surface Dial `hidraw` device. It starts Bluetooth when required but does not change Volumio's boot-time Bluetooth service policy.

## Install from GitHub

Until the plugin is available through the official Plugin Store, enable SSH in Volumio and run:

```sh
cd /home/volumio
git clone https://github.com/jhscann/volumio-surface-dial.git
cd volumio-surface-dial
volumio plugin install
```

If the repository has already been cloned:

```sh
cd /home/volumio/volumio-surface-dial
git pull
volumio plugin install
```

After installation:

1. Open **Plugins → Installed Plugins**.
2. Find **Surface Dial** under **System Hardware** and enable it.
3. Open **Settings** for the plugin.
4. Hold the pairing button on the underside of the Surface Dial until its LED flashes.
5. Select **Scan for Surface Dial**.
6. Re-open Settings if necessary so the discovered Bluetooth address is displayed.
7. Select **Pair selected Surface Dial**.

The Dial is marked trusted during pairing. If it later sleeps or loses the Bluetooth link, wake it by pressing or rotating it; the plugin will request reconnection automatically and resume HID control without re-pairing.

## Configuration

| Setting | Default | Description |
| --- | ---: | --- |
| Surface Dial Bluetooth address | blank | Selected by Scan; may also be entered manually. |
| Reverse rotation direction | Off | Swaps clockwise and anticlockwise volume behaviour. |
| Single press | Play / Pause | Action after one short press. |
| Double press | Next track | Action after two short presses within the configured window. |
| Long press | Previous track | Action after holding the Dial for the configured threshold. |
| Haptics | On | Enables both 50-step rotational feedback and button-action feedback. |
| Double-press window | 420 ms | Maximum interval used to distinguish a double press from a single press. |
| Long-press threshold | 700 ms | Minimum hold time treated as a long press. |
| Reconnect interval | 5 s | Interval used when the plugin needs to rediscover/reconnect the Dial. |

Volume change per detent is intentionally not configurable: it is fixed at 2% so 50 physical detents map cleanly to the complete 0–100% volume range.

Available press actions are **Play / Pause**, **Next track**, **Previous track**, and **Do nothing**.

See `docs/CONFIGURATION.md` for additional detail.

## How it works

```text
Surface Dial
    │ Bluetooth HID
    ▼
Linux BlueZ / HID subsystem
    │
    ▼
/dev/hidraw*
    │
    ▼
Volumio Surface Dial plugin
    ├─ programs 50-step hardware haptics
    ├─ parses rotation and button reports
    ├─ recognises single / double / long press
    ├─ reconnects the trusted Bluetooth device after sleep/drop-out
    └─ sends Volumio playback / volume commands
```

The plugin reads `hidraw` directly from the Volumio Node process. The bundled `scripts/set-dial-feature.py` helper uses Linux HID feature reports to configure the Dial's 50-step automatic haptics; it is invoked only when needed and is not a daemon.

## Permissions and system changes

`install.sh` creates `/etc/udev/rules.d/99-volumio-surface-dial.rules`. The rule is limited to the Microsoft Surface Dial identifiers used by this plugin and grants the `volumio` group access to the corresponding `hidraw` device.

The installer refuses to overwrite a pre-existing file at that path unless it carries this plugin's ownership marker. `uninstall.sh` similarly removes only a rule file marked as belonging to this plugin. Shared BlueZ/Python packages are not removed and Bluetooth is not disabled during uninstall.

The plugin does not modify `/volumio` or `/myvolumio`.

## Troubleshooting

See `docs/TROUBLESHOOTING.md`. Useful first checks are:

```sh
bluetoothctl devices
bluetoothctl info <MAC>
ls -l /dev/hidraw*
cat /sys/class/hidraw/hidrawX/device/uevent
journalctl -u volumio -f
```

## Development and submission testing

Run unit tests with:

```sh
npm test
```

Before Plugin Store submission/promotion, complete `docs/TESTING.md`, including clean install, lifecycle log, sleep/wake reconnect, haptic, uninstall and `volumio plugin package` checks.

## Known limitations

- Wider testing across Volumio hardware platforms and Bluetooth adapters is still desirable.
- **Wireless Output Manager compatibility:** Surface Dial sleep/reconnect activity may interrupt Bluetooth audio when Surface Dial and Wireless Output Manager share the same Bluetooth adapter. If playback stutters, disable the Surface Dial plugin. Separating the Dial and speaker onto different adapters prevented the interruption in one Raspberry Pi/Volumio 4 test, but Wireless Output Manager may need explicit adapter selection to reconnect its speaker after reboot.
- Bluetooth discovery output can vary between BlueZ releases.
- Battery level is not exposed.
- Rotation controls volume only; there is currently no secondary seek/navigation mode.
- The settings page selects the first discovered device whose Bluetooth name matches `Surface Dial`.

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
