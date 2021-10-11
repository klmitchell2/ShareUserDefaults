# ShareUserDefaults
A Theos tweak to share the contents of `NSUserDefaults` from a running process via `UIActivityViewController`. Contributions and feedback are welcome!

## Installation 
- Confirm in the `MakeFile` that `THEOS_DEVICE_IP` & `THEOS_DEVICE_PORT` are pointing to your jailbroken device.
- `make package install` in this directory.

## Usage
- Open up any app on your jailbroken device.
- An alert will be displayed, pressing Yes results in a `UIActivityViewController` being displayed.
- Airdrop the UserDefaults text file to your computer.

## Testing Enviroment
- This tweak was tested on an iPhone 8 Plus running iOS 14.8 and jailbroken with Checkra1n.

## Future Enhancements
- Ability to view `NSUserDefaults` on the phone.
- Ability to turn on/off the tweak in settings.
