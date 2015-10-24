# pecs-fw
A collection of the production firmware images for the PECS ensemble

Component | Production Version | Latest Version | Known Issues
----------|--------------------|----------------|-------------------
Kernel    | 1.0                | 1.0            | Yes, see changelog
Userland  | 1.0                | 1.0            | Yes, see changelog
BLE       | -                  | -              | Nonexistence
Haptic UI | 1.2                | 1.2            | None

# Changelog

#### Kernel 1.0
 - Incorporated timer overflow patch
 
Known issues:

 - No watchdog
 - Only works on BR 2001:470:83ae:2:212:6d02:0:400d

#### Userland 1.0
 - Initial version

Known issues:

 - Does not persist settings on restart
 - Does not kick a watchdog
 - Will crash if peripheral boards are plugged in while the system is powered on. This issue we hope to solve with the watchdog additions
 - Does not set the UI status LED based on battery
 
#### Haptic UI 1.2
 - First production version
 - All functionality implemented
 - WDT set to 4s

Known issues:

 - Processor does not utilize XLP modes. This is likely a wontfix because the LEDs far outweigh any benefits from XLP.
