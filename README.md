# TinyAstro
Scripts to build TinyAstro image. 

## Support device 

* RK3188 + AP6210(internal WIFI as AP)
* Odroid C1 + RTL8192CU(usb WIFI as AP)

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

```
sudo ./create_odroid_image
```

** These scripts is base on loboris's
"Ubuntu & Debian debootstrap instalation" scripts from [forum of odroid](http://forum.odroid.com/viewtopic.php?f=112&t=8075) **
