#!/bin/bash

#
# qhyReset.bash
#
#  Created on: 01.09.2013
#      Author: Giampiero Spezzano (gspezzano@gmail.com)
#
# This file is part of "OpenSkyImager".
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#ROOT_UID=0

#if [ "$UID" -ne "$ROOT_UID" ]
#then
#  echo "You need to be root to run this program."
#  exit 0
#fi

E_WRONG_ARGS=85
MINPARAMS=3

if [ $# -lt "$MINPARAMS" ]
then
	echo
	echo "Usage: qhyReset.bash <in vid:pid> <out vid:pid> fw-filepath!"
	exit $E_WRONG_ARGS
fi  

#Collect paramenters in named vars for ease of use
src1=$1
src2=$2
fwfl=$3
flnm=${fwfl##*/}
bdir=${fwfl%$flnm}
fwf2=$bdir"qhy5loader.hex"

if [ "$src2" == "16c0:296d" ]
then
	# Since it's a QHY5 we test if loader is present in the same folder
	if [ ! -e "$fwf2" ]
	then
		echo "This device also needs the loader: $fwf2 that was not found."
		exit 3
	fi
fi

# System dependent variants
bdir="/dev/bus/usb"
if [ ! -d "$bdir" ]
then
  bdir="/proc/bus/usb"
fi

# see if there is the unconfigured device to be found
bd=$( lsusb | grep $src1 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
dev="$bdir/$bd"

if [ "$src2" == "16c0:296d" ]
then
	#QHY5 has several "raw device variants", sic.
	if [ "$dev" == "$bdir/" ] 
	then
		bd=$( lsusb | grep 1618:1002 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
		dev="$bdir/$bd"
	fi
	if [ "$dev" == "$bdir/" ] 
	then
		bd=$( lsusb | grep 0547:1002 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
		dev="$bdir/$bd"
	fi
	if [ "$dev" == "$bdir/" ] 
	then
		bd=$( lsusb | grep 04b4:8613 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
		dev="$bdir/$bd"
	fi
	if [ "$dev" == "$bdir/" ] 
	then
		bd=$( lsusb | grep 16c0:081a | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
		dev="$bdir/$bd"
	fi

	if [ "$dev" == "$bdir/" ] 
	then
		bd=$( lsusb | grep 1856:0011 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
		dev="$bdir/$bd"
	fi	
fi

# if we have found a camera, lets reprogram it.
if [ "$dev" != "$bdir/" ] 
then
	echo "Loading firmware for $dev (3 sec delay)" 
	if [ "$src2" != "16c0:296d" ]
	then
		#This is not QHY5
		/sbin/fxload -t fx2 -I $fwfl -D $dev
	else
		#This is for QHY5
		/sbin/fxload -t fx2 -I $fwfl -D $dev -s $fwf2
	fi
	sleep 3
else
	bd=$( lsusb | grep $src2 | cut -d ' ' -f 2,4 | sed -e 's/ /\//' -e 's/://' )
	dev="$bdir/$bd"
	if [ "$dev" != "$bdir/" ] 
	then
		echo "Resetting $dev..."
		if [ "$src2" != "16c0:296d" ]
		then
			#This is not QHY5
			/sbin/fxload -t fx2 -I $fwfl -D $dev
		else
			/sbin/fxload -t fx2 -I $fwfl -D $dev -s $fwf2
		fi
		sleep 3
	else
		echo "Neither raw device ($src1) nor programmed device ($src2) found."
		exit 2
	fi
fi

bd=$( lsusb | grep $src2 )

if [ -z "$bd" ] 
then
	echo "Device $src2 still not found after reset."
	exit 1
fi

exit 0
