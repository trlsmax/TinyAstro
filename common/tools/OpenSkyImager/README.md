OpenSkyImager
=============
OpenSkyImager is a capture program written for Astronomy camera operation.

Some of the code has been borrowed and/or adapted from other GPL/LGPL or other
"free software" licensed projects.

Credits to individual authors or organizations can be found in source files
where most appropriate.

Therefore, this program is licensed under GNU GPL 3.0.

This program is free software: you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details. 

You should have received a copy of the GNU General Public License along with 
this program.  If not, see <http://www.gnu.org/licenses/>.


Supported camera list
==================
As of version 0.8.8 several QHY camera are actively developed against:
QHY2 (old color model),5,5II series,6 (both firmware),7,8(Old),8L,9,10,11,12.

Models that have been 100% tested are: QHY5,5II series,6 (both firmware),7,
8(Old)8L,9,11,12.

If your camera make/model does not appear in the list you can try contact us
and see if it can be add in a near future.
If your camera is in the list, but not 100% tested, please leat us know your
user experience. You're also most welcome to volunteer for helping bebug.

For different camera make a freely available official technical documentation 
must be available and legally available firmware (if applicable) are needed.
A GPL licensed linux SDK would sure speed up things a great deal.

For other QHY models we suggest to give a look at the official SDK release:
https://github.com/qhyccd-lzr 

If firmware for your camera appears there, we may already be able to proceed, 
but your assistence will be needed for testing.

If not a request can be submitted on the QHY forum http://www.qhyccd.com/ccdbbs

Color filter wheel support
=======================
As of version 0.6.0 QHY 5 positions 2" is supported, both with serial and 
through camera connection.
Models that are known to suppor cfw-through connection are QHY7/9/11.

Internationalization
==================
As of version 0.6.0 only embedded Us English, Italian, French and Chinese are 
available.
There is an ongoing effort for German and Spanish, going on already.
Please feel free to volunteer for additional languages.

The program does conform to "gettext", the de facto standard as far as linux 
internationalization is concerned.

More in-deep instructions and hints may be found in the "po" folder.

Compiling and installing
=====================
As of version 0.8.4 a custom install script has been introduced thanks to Clive
Rogers (install_OSI.bash).
This script will check for dependencies, (prompt for install if needed), compile 
and install the program in a suitable folder (both GTK2 & GTK3 versions).
User interaction may be needed to create a menu entry, if so desired.

However should anyone prefer to do all by hands here's what's needed and how to:

Compiling your binary
===================
The program was written to compile with both GTK2 and GTK3 toolkit. 
Different binaries of course, as on some systems both will work.

You will need these libraries, both binaries and dev.
Please get them from your repo:
GTK2 >= 2.20 / GTK3 >= 3.20
GLIB >= 2.24
CFITSIO & LIBUSB1.0 as you get them from repos of a >= Year 2010 distro.

So far several combinations have been tested:
- GTK2 
	- Mint13 (GTK2 2.24, Glib 2.32), 
	- Ubuntu 11.10 (GTK2 2.24 GLib 2.30)
	- Mint 9 (GTK2 2.20 GLib 2.24)
	
- GTK3 
	- Mint LMDE amd64 (GTK3 3.82, Glib 2.36)
	- Mint13 (GTK3 3.42, Glib 2.32) 
	- Ubuntu 11.10 (GTK3 3.2 GLib 2.30)
	- Arm device (ASUS transformer TF101) using debian kit over android 4.1.x, 
	  running a deb wheezy, xrdp to display the X session
	  
To compile your binary, once you got suitable libs as listed above, on the 
command line issue:
	make GTK_VERSION=2  -> GTK2 version
	make                -> GTK3 version
	
The makefile support "install", "update" and "clean" arguments.
- Install will wipe any currently installed file (remove the folder actually)
  make GTK_VERSION=2 install -> GTK2 version
  make               install -> GTK3 version
- Update will just overwrite / add what is needed
  make GTK_VERSION=2 update  -> GTK2 version
  make               update  -> GTK3 version
- Clean will cleanup the compile folder from *.o and target binary file.
  make GTK_VERSION=2 clean   -> GTK2 version
  make               clean   -> GTK3 version

As of current version features of the two variants are *exactly* the same, while
appearance may differ a bit, also depending on your "theme" settings.

You're not expected to see error messages or warnings while compiling. If so, 
let us know. 
Submit details for your hardware / software configuration so that we'll be 
able to track down any issue effectively.

Installing
=========
Once you compiled your binaries, we suggest to:
- create a "OpenSkyImager" folder into /urs/local/bin
- copy the binary to that location
- copy all "language" folders (it_IT, for now) in same location
- copy the qhyReset.bash in same location
- copy all .png files in same location
- be sure to set the execute bit on binary and bash

*OR* you can use the enclosed install script (thanks to Clive Rogers).

Should you need an entry in the applications menu, create a suitable .desktop
file, where most appropriate for your distro.

The program can be run from any other location, proven that the above 
"compoments" are all in the same folder.

User manual
==========
As of version 0.8.8 the first release of a user manual has been created, thanks
to the kind work of Mr. Clive Rogers.

Sincerely
*The OpenSkyProject team*


