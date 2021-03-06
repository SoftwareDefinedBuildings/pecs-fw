# pecs-fw
A collection of the production firmware images for the PECS ensemble

Component     | Production Version | Latest Version | Known Issues
--------------|--------------------|----------------|-------------------
Kernel        | 4.0.7              | 4.0.7          | None
Userland      | v4                 | v4             | Yes, see changelog
BLE           | -                  | -              | Nonexistence
Haptic UI     | 1.3                | 1.3            | None
Border Router | 1.4                | 1.4            | Yes, no watchdog
Stormloader   | 1.7.0              | 1.7.0          | None

## Getting Started

From your Terminal application/emulator:

```
git clone https://github.com/SoftwareDefinedBuildings/pecs-fw
cd pecs-fw
pwd
# this will print out what directory the repository is in.
# Make a note of this
```

To flash a chair, find the directory `pecs-fw` that you created
above and double clck the `update_chair_osx` script.

# Expected Flash Attributes

Index | Key         | Value                             | Value Example
------|-------------|-----------------------------------|--------------
0     | serial      | serial number for the mote        | `f00d`
2     | meshpfx     | IPv6 prefix for this mote         | `2001:470:1234:2::`
7     | border      | Node ID for the one-hop border router | `400e`

## Serial Number Attribute

Serial attribute should be already in the device. You can verify by running:
```bash
$ sload gattr
serial => 40 0e # index 0
 =>             # index 1
 =>             # etc...
etc...
```

If serial attribute is gone (that is, the first position is just ` => `), you can look
at the number on the back of your board (e.g. "400e") and set it:

```bash
$ sload sattr -x 0 serial 400e
```

and then verify.

## IPv6 Number Attribute

Instead of grabbing the IPv6 prefix from the Makefile, we are now grabbing it from attribute 2,
which you can set via

```
$ sload sattr 2 meshpfx 2001:470:4112:2::
```

If you are a mote and want to have a statically configured border router, you can set the border
router address via an attribute. This is assuming you have been compiled with `RPL_SINGLE_HOP`,
which is most likely the case if you are a non-border router.

```
$ sload sattr 7 border 400d # this is the nodeID of the router
```

These can be accomplished in a single step with the `sload moteconfig` command:

```
$ sload moteconfig 2001:470:4112:2:: 400d
```

which sets the prefix and the border router one-hop address (`fe80::212:6d02:0:400d` in this case).

Make sure to run `sload tail` after changing any attributes.

## Border Router Attributes

We augment the above table to include what the border router expects

Index | Key         | Value                             | Value Example
------|-------------|-----------------------------------|--------------
0     | serial      | serial number for the mote        | `f00d`
2     | meshpfx     | IPv6 prefix for this mote         | `2001:470:1234:2::`
3     | remtun      | IPv4 address of the remote tunnel | `10.4.10.3`
4     | loctun      | IPv4 address of the border router | `10.4.10.2`
5     | locmask     | Netmask for the border router IPv4 network | `255.255.255.0`
6     | locgate     | Gateway for border router IPv4 network    | `10.4.10.1`

These can be set with the `sload borderconfig` command. See [stormloader](https://github.com/SoftwareDefinedBuildings/stormloader)
which can be installed with `pip install stormloader`.


# Changelog

#### Userland v4
 - Add timebase resynchronization
 - Switch top/bottom dials
 - Make dials turn off when unoccupied
 - Add support for haptic UI 1.3
 - Add battery level checking
 - Report battery ok status
 - Requires kernel 4.0.7 and haptic UI 1.3. Best if used with burnfuses --bor --wdt

#### Kernel 4.0.7
 - Integrate new timer code
 - Fix watchdog so that it still reconfigures if burnfuses --wdt is used

#### Userland v3
 - Fix for log when packets are duplicated and arrive at EXACTLY the wrong time
 - Remove overly noisy settings print
 - Add version number print on startup

#### Userland v2
 - Fix log pointer race
 - Repeatedly sets status LED to avoid power sequencing race

#### Kernel 4.0.6
 - Fixed steve's incorrect IP packet checksum algorithm

#### Kernel 4.0.4
 - Incorporated timer overflow patch
 - Added watchdog
 - Added flash attributes

#### Userland v0
 - Initial version
 - Added persisted settings on restart
 - Added watchdog kicking

Known issues:

 - Will crash if peripheral boards are plugged in while the system is powered on.
 - Does not set the UI status LED based on battery

#### Haptic UI 1.2
 - First production version
 - All functionality implemented
 - WDT set to 4s

Known issues:

 - Processor does not utilize XLP modes. This is likely a wontfix because the LEDs far outweigh any benefits from XLP.


#### Border Router 1.4
 - Updated to Kernel 4.0.6
 - Fixed UDP checksum

Known issues:
 - No watchdog
