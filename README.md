# ShareUserDefaults
A Theos tweak to share the contents of UserDefaults from a running process via `UIActivityViewController`.

## Installation 
- Confirm in the `MakeFile` that `THEOS_DEVICE_IP` & `THEOS_DEVICE_PORT` are pointing to your jailbroken device.
- `make package install` in this directory.

## Usage
- Open up any app on your jailbroken device.
- An alert will be displayed, pressing Yes results in a `UIActivityViewController` being displayed.