# Configuration reference

## Device

### Surface Dial Bluetooth address (`device_mac`)
The paired Dial's Bluetooth MAC address. Normally populated by **Scan for Surface Dial**. It may be entered manually if the device has already been discovered with BlueZ.

### Scan for Surface Dial
Runs an approximately eight-second BlueZ discovery window and filters devices whose Bluetooth name matches `Surface Dial`. The first match is stored. Put the Dial into pairing mode before scanning.

### Pair selected Surface Dial
Pairs the selected Dial using BlueZ's `NoInputNoOutput` agent, marks it trusted and connects it. Trusting the device allows the plugin to request reconnection after the Dial sleeps or the Bluetooth link drops.

### Forget Surface Dial
Removes the stored device from BlueZ and clears the saved MAC address.

## Controls

### Volume
Volume mapping is deliberately fixed rather than configurable. The plugin programs the Dial for **50 detents per complete revolution** and each detent changes Volumio volume by **2 percentage points**. One complete revolution therefore spans the full 0–100% volume range.

### Reverse rotation direction (`reverse_rotation`)
Default: off. Swaps clockwise and anticlockwise volume behaviour.

### Single press (`single_press`)
Default: Play / Pause. Fired after the double-press window expires without a second short press.

### Double press (`double_press`)
Default: Next track. Fired when two short releases occur within the double-press window; the pending single-press action is cancelled.

### Long press (`long_press`)
Default: Previous track. Fired on release when the Dial has been held for at least the configured threshold.

Available press actions: Play / Pause, Next track, Previous track, Do nothing.

### Haptics (`haptics`)
Default: on. Controls Surface Dial haptic feedback globally. When enabled, the Dial provides tactile feedback for the 50 rotational detents and the plugin provides confirmation feedback for configured button actions. When disabled, both are suppressed.

## Advanced

### Double-press window (`double_press_ms`)
Default: `420 ms`; runtime minimum: `200 ms`.

### Long-press threshold (`long_press_ms`)
Default: `700 ms`; runtime minimum: `300 ms`.

### Reconnect interval (`reconnect_seconds`)
Default: `5 seconds`; runtime minimum: `1 second`. When the HID device is absent, the plugin also asks BlueZ to reconnect the saved trusted Dial. After waking the Dial, control should resume automatically without re-pairing.
