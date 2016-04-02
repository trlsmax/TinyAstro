#!/bin/sh
rfkill unblock all
/home/astro/tools/brcm_patchram_plus -d --patchram /system/etc/firmware/bcm20710a1.hcd --no2bytes --tosleep 1000 /dev/ttyS0
hciattach /dev/ttyS0 any
