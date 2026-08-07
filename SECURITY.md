# Security policy

The project is currently experimental. Security fixes will target the current `main` branch until stable releases are tagged.

Please do not publish security-sensitive issues containing exploit details, private device information or credentials. Use GitHub private vulnerability reporting if enabled, or contact the repository owner privately through GitHub.

The installer may install the `bluez` package if `bluetoothctl` is absent, writes `/etc/udev/rules.d/99-volumio-surface-dial.rules`, reloads udev rules, and enables/starts `bluetooth.service` where available. At runtime the plugin invokes fixed `bluetoothctl` and Volumio CLI executables and directly opens the Surface Dial `hidraw` device.
