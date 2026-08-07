# Changelog

## [Unreleased]
### Planned
- Complete first real Surface Dial + Volumio 4 hardware validation.
- Refine BlueZ pairing UX based on real-device testing.
- Add programmable detent / automatic haptic support if reliable.
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
