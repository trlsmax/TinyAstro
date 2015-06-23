# TinyAstro
Scripts to build TinyAstro image. 
TinyAstro is a ARM Linux system with Kstars and INDI libs.
With your mobile phone or tablet, you can control your gears
without a computer.

## Support device 

* RK3188 + AP6210(internal WIFI as AP)
* Odroid C1 + RTL8192CU(usb WIFI as AP) (HDMI not test yet)

## Require

1. Ubuntu/Debian linux system
2. debootstrap and qemu-user-static

```
sudo apt-get install debootstrap qemu-user-static
```

## Install

### Get root file system

```
sudo ./create_rfs
```

### Build image for RK3188

```
sudo ./create_rk_image
```

### Build image for Odroid C1

set BOARD=C1 in create_odroid_image and run
```
sudo ./create_odroid_image
```

### Build image for Odroid U3

set BOARD=U3 in create_odroid_image and run
```
sudo ./create_odroid_image
```

## Usage

user name : `astro`

password: `astronomy`

use vncviewer to connect port 5900 and you will get a desktop

If you use WIFI AP, there will be a AP SSID like `TinyAstro_xxxxxx`
connect it with password `astronomy`.

*** These scripts is base on loboris's
"Ubuntu & Debian debootstrap instalation" scripts from [forum of odroid](http://forum.odroid.com/viewtopic.php?f=112&t=8075) ***
