# Changelog

## [0.2.1] - 2026-08-14
### Fixed
- Validate the complete nine-byte Surface Dial input report before generating rotation or button events, ignoring unrelated report types.
- Ignore unmatched or duplicate button state reports so one physical press produces at most one configured action.
- Clear pending button gestures when the HID reader disconnects, preventing a stale release from issuing a playback command after reconnect.

## [0.2.0] - 2026-08-08
### Added
- Hardware-validated programmable Surface Dial haptics using Linux HID feature reports.
- Fixed 50-detent rotary mapping: one complete revolution represents the full 0–100% Volumio volume range, with 2% per detent.
- Unified **Haptics** setting controlling rotational and button-action feedback, enabled by default.
- Bundled `scripts/set-dial-feature.py`; the installer verifies it is present, makes it executable and ensures Python 3 is available.
- Bluetooth trust/connect support for automatic reconnection after the Dial sleeps or loses its link.
- Submission-oriented installation and hardware validation checklist.

### Fixed
- Volumio 4 settings UI controller endpoint schema.
- Rapid rotation volume handling now accumulates target volume rather than racing asynchronous volume reads.
- Automatic reconnect now asks BlueZ to reconnect when the paired Dial has dropped its Bluetooth connection.
- Removed obsolete configurable volume-step and experimental haptic settings/documentation.
- Installer now refuses to overwrite an unrelated pre-existing udev rules file.
- Uninstaller removes only a udev rules file explicitly marked as owned by this plugin.
- Installer no longer changes the system's boot-time Bluetooth enable/disable policy.

## [0.1.1] - 2026-08-07
### Fixed
- Return `kew` promises from Volumio lifecycle methods so Volumio recognises plugin start and stop correctly.
- Declare `kew` explicitly as a runtime dependency.

## [0.1.0] - 2026-08-07
### Added
- Initial `system_hardware` plugin.
- Direct `hidraw` Surface Dial report parsing.
- Bluetooth scan, pair and forget actions through BlueZ.
- Volume control from rotation.
- Configurable single, double and long press actions.
- Automatic HID reconnect loop.
- Volumio install/uninstall scripts and scoped udev permissions.
- Unit tests and hardware validation checklist.
