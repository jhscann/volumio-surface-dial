# Contributing

Contributions are welcome, especially reports from different Volumio 4 devices, Bluetooth adapters and Surface Dial firmware revisions.

Before opening an issue, include the Volumio version and architecture, hardware platform, Bluetooth adapter/chipset where known, whether plugin pairing succeeds, relevant `bluetoothctl info <MAC>` / `hidraw` information, and exact observed control behaviour. Do not include credentials or other sensitive data.

For pull requests: create a focused branch; keep the plugin self-contained so users do not need a separate manually installed daemon/application; preserve `onStart()` / `onStop()` lifecycle behaviour; add tests where practical; run `npm test`; and update documentation for user-visible changes. Explain any new udev, BlueZ or privilege requirements.
