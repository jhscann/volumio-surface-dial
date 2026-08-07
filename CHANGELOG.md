# Changelog

## [Unreleased]
### Added
- Hardware-validated programmable Surface Dial haptics using Linux HID feature reports.
- Fixed 50-detent rotary mapping: one complete revolution represents the full 0–100% Volumio volume range, with 2% per detent.
- Bundled `scripts/set-dial-feature.py`; the installer now verifies it is present, makes it executable, and ensures Python 3 is available.
- Bluetooth trust/connect support for automatic reconnection after the Dial sleeps.

### Fixed
- Volumio 4 settings UI controller endpoint schema.
- Rapid rotation volume handling now accumulates target volume rather than racing asynchronous volume reads.
- Automatic reconnect now asks BlueZ to reconnect when the paired Dial has dropped its Bluetooth connection.

### Planned
- Continue real-device validation of sleep/wake behaviour across Volumio hardware platforms.
- Consider seek or secondary control modes.

## [0.1.1] - 2026-08-07
### Fixed
- Return `kew` promises from Volumio lifecycle methods so Volumio 4 recognises plugin start and stop correctly.
- Declare `kew` explicitly as a runtime dependency.

## [0.1.0] - 2026-08-07
### Added
- Initial experimental `system_hardware` plugin.
- Direct `hidraw` Surface Dial report parsing.
- Bluetooth scan, pair and forget actions through BlueZ.
- Volume control from rotation.
- Configurable single, double and long press actions.
- Automatic HID reconnect loop.
- Experimental manual confirmation haptic.
- Volumio install/uninstall scripts and scoped udev permissions.
- Unit tests and hardware validation checklist.
