# Expected Flash Attributes

Index | Key         | Value                             | Value Example
------|-------------|-----------------------------------|--------------
0     | serial      | serial number for the mote        | f00d
2     | meshpfx     | IPv6 prefix for this mote         | 2001:470:1234:2::

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

Make sure to run `sload tail` after changing any attributes.

## Border Router Attributes

We augment the above table to include what the border router expects

Index | Key         | Value                             | Value Example
------|-------------|-----------------------------------|--------------
0     | serial      | serial number for the mote        | f00d
2     | meshpfx     | IPv6 prefix for this mote         | 2001:470:1234:2::
3     | remtun      | IPv4 address of the remote tunnel | 10.4.10.3
4     | loctun      | IPv4 address of the border router | 10.4.10.2
5     | locmask     | Netmask for the border router IPv4 network | 255.255.255.0
6     | locgate     | Gateway for border router IPv4 network    | 10.4.10.1

These can be set with the `sload borderconfig` command. See [stormloader](https://github.com/SoftwareDefinedBuildings/stormloader)
which can be installed with `pip install stormloader`.

