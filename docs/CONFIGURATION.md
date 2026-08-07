# Configuration reference

## Device

### Surface Dial Bluetooth address (`device_mac`)
The paired Dial's Bluetooth MAC address. Normally populated by **Scan for Surface Dial**. It may be entered manually if the device has already been discovered with BlueZ.

### Scan for Surface Dial
Runs an approximately eight-second BlueZ discovery window and filters devices whose Bluetooth name matches `Surface Dial`. The first match is stored. Put the Dial into pairing mode before scanning.

### Pair selected Surface Dial
Runs BlueZ pairing with the `NoInputNoOutput` agent. Current BlueZ `pair` behaviour is expected to pair, trust and connect the device.

### Forget Surface Dial
Removes the stored device from BlueZ and clears the saved MAC address.

## Controls

### Volume change per detent (`volume_step`)
Default: `2`. Each rotation event changes Volumio volume by this percentage. Runtime input is limited to 1–20%.

### Reverse rotation direction (`reverse_rotation`)
Default: off. Swaps clockwise and anticlockwise behaviour.

### Single press (`single_press`)
Default: Play / Pause. Fired after the double-press window expires without a second short press.

### Double press (`double_press`)
Default: Next track. Fired when two short releases occur within the double-press window; the pending single-press action is cancelled.

### Long press (`long_press`)
Default: Previous track. Fired on release when the Dial has been held for at least the configured threshold.

Available press actions: Play / Pause, Next track, Previous track, Do nothing.

### Experimental confirmation haptic (`manual_haptic`)
Default: off. Attempts a basic five-byte Surface Dial haptic output report after a button action.

## Advanced

### Double-press window (`double_press_ms`)
Default: `420 ms`; runtime minimum: `200 ms`.

### Long-press threshold (`long_press_ms`)
Default: `700 ms`; runtime minimum: `300 ms`.

### Reconnect interval (`reconnect_seconds`)
Default: `5 seconds`; runtime minimum: `1 second`.
