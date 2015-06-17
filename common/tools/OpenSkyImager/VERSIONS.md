Versions
========

*Version 0.6.2*
- Minor fix to allow seamless compiling on fedora (cfitsio lib in different 
  location) and some optimizing on conditional compiling
- Fixed a bug in conditional code not allowing GTK2 clean compile
- Fixed some troubles when compiling on old distro
- Fixed a typo on message string context
- Introduced a basic user input filter for exp. time and temp.
- Found an fixed a bug with locale that use "," as decimal
- update Simple Chinese translation
- Fix TEC graph growing in time (again, sic)
- Temp reading feature for QHY5L-II
- QHY5L-II smoother operation, max_gain settings updated
- Solved CFW disconnect requiring 2 clicks in tty mode
- Update language file (Italian / French finalized) to let translators

*Version 0.7.0*
- Adding Avi save feature (8Bit data into RGB24 raw, registax compatible)
- Add split avi file > 2Gb, max counters to 9999
- Fixed crash when image save folder does not exist
- Changed how QHY5 reset is performed (much more dependable)
- Adding ROI feature for FWHM calculation. ROI will chase selected "star"
- Changed status bar position to top. Split in 3 for better space management
- Prevented strange behavior of sscanf with empty strings on some systems
- Reworked the "shutter trick" for QHY7
- Tec controlling loop is now based on a timer, proved more effective
- Fixed single core operation
- Better UI responsiveness during long waiting loops
- Speed up focus mode (fast download). Tec reading and feedback are disabled,
  restored when slow speed mode or capture is set
- New "dark / light" frame feature for QHY9

*Version 0.7.1*
- Add save image header info for fit files

*Version 0.7.2*
- Add save image header info for avi files (in a txt file)
- Image header info extended (camera pixel size x/y and observer)
- Vid/Pid of raw "Orion StarShooter" add to the list of QHY5 raw devices

*Version 0.7.3*
- New radio toggle-buttons for Capture/Focus mode selection
- Qhy8l now fully supported (special thanks to Anat Ruangrassamee for help)

*Version 0.7.4*
- Fix subframe not centered on the ccd for qhy8l

*Version 0.7.5*
- Fix preview showing only B/W for QHY5L-II

*Version 0.8.0*
- Add remote control on a fifo, integration with iAstroHub
already tested (http://sourceforge.net/projects/iastrohub/).
- Fit Header fix:
	- change pixel size keys
	- add EXPOSURE key
	- add SET-TEMP key
	- Adapted a few key to be more compatible

*Version 0.8.1*
- Pre processor code updated to cope with GTK 3.8 version (avoid deprecated)

*Version 0.8.2*
- New Qhy12 support. Fully functional excep subframe
- New bad data filtering, especially useful for QHY5L-II
- Fix memory leak when in color mode

*Version 0.8.3*
- New commands for remote operation: SETROIPOS, GETROIPOS, SETROISIZE, HIDEROI,
  GETFWHM (please see REMOTE.md for details)
- Fixed ROI possibly hitting image borders and crash application
- Fixed segfault if running with -f only

*Version 0.8.4*
- New command for remote operation: LOADFILE (please see REMOTE.md for details)
- Changed oputput format for SETROIPOS and GETROIPOS
- HFD (Half flux diameter) replace FWHM
- fixed a possible source of crash while positioning ROI
- introduced a compile/install script (thanks to Clive Rogers)
- Add warning dialogs while attempting program quit or camera disconnect 
  when capture thread is running
- SECURITY PATCH: when cooled camera is in fast mode and TEC read / feedback is
  disabled, widgets are now "grayed out". - WARNING - forcing TEC control while 
  camera is in fast mode can lead to false Temp reading and unpredictable - yet
  dangerous - behavior. Please avoid doing this when using previous versions 
  and / or update your version.

*Version 0.8.5*
- Add DSI2PRO camera support, capture was tested, temp read should work, but 
  true temperature match must be confirmed. Beta tester wanted.

*Version 0.8.6*
- Fix QHY8 Bin2/4 image corrupted (thanks to Daniel Holler for report) 
- QHY12 image flipped vertically (thanks to Anat Ruangrassamee for report)
- Fix program crash if setting CFW filters while "Add filter" is selected

*Version 0.8.7*
- Fix incorrect date written when using "Add Date" (thanks to Clive Rogers)
- Fix "Save As" dialog not allowing for new folder (thanks to Clive Rogers)
- New: ROI star zoomed into the preview thumbnail
- Update to the install script from Clive Rogers

*Version 0.8.8*
- New: QHY10 support (experimental)
- New: first release of the user manual (thanks to Clive Rogers)
- Fix: link to web site

*Version 0.8.9*
- New: QHY10 / QHY12 subframe feature (thanks to Anat Ruangrassamee for testing)

*Version 0.8.10*
- New: New Makefile to compile and install (please see README for details)
- update install_OSI to use the new makefile
- update Simple Chinese translation

