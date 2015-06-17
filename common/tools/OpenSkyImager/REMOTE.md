Remote control
==============

Starting from version 0.8.0 OpenSkyImager offers a remote control feature.
Communication between client and OpenSkyImager happens on a named pipe, for
command input, on the stdout for output and messages.

To enable the remote control mode, OpenSkyImager must be invocked with the
optional -f parameter.
OpenSkyImager will create a default named pipe (/tmp/*-binary name-*), unless
-F*-custom_named_pipe_file_path-* is used.

While in remote control mode OpenSkyImager does also offer optional jpg preview
images for both "focus" and "capture" frames.
For "focus" frames *-current_named_pipe_file_path-*.jpg  will be used.
For "captured" frame the full current naming convention will be used (+ .jpg).

Commands on the input fifo will follow this general rule: "COMMANDNAME:value" or
"COMMANDNAME:" when there's no optional value to sent.

OpenSkyImager will respond with "Fifo: COMMANDNAME=value" or 
"Fifo: COMMANDNAME=ACK" where most appropriate.
If value is not accepted or other unexpected conditions prevent program to 
fulfill the request, a "Fifo: ERROR=*description*" will be returned.

Both command and responses will be new line terminated, or the pipe must be 
close like in: echo "EXPTIME:100" > /tmp/gtkImager .

Unrecognized command will output: Fifo: Unknown command;

OpenSkyImager will reflect on it's gui all modifications from remote commands.

While running "focus" or "capture" a message will be sent on the stdout to 
confirm a new preview image is available:
"Fifo: PREVIEW=New preview image available".

*As of version 0.8.0* the following commands are available:

- EXPTIME:ms, Exposure time in ms
- TOTSHOTS:number, Shots to do in a run
- SAVSHOTS:number, Shots saved already (useful to number future shots)
- MAXADU:0-255/0-65535, Preview max adu (prw image will be saved accordingly)
  Will retrun ERROR=MaxAdu out of range (*min*-*max*), value can't be less than
  READMINADU
- READMAXADU:, Will return MAXADU current value
- MINADU:0-255/0-65535, Preview min adu (prw image will be saved accordingly)
  Will retrun ERROR=MinAdu out of range (*min*-*max*), value can't be more than
  READMAXADU
- READMINADU:, Will return MINADU current value
- TECREAD:0-1, Enable / disable tec read feature
  Will return Fifo: ERROR=No TEC to read, if camera has no TEC or temp read
- TECAUTO:0-1, nable disable tec feedback mode (using current target temp)
  Will return Fifo: ERROR=No TEC to set, if camera has no TEC
- SETTEMP:float value, Set target temperature (if tecread & tecauto are not set 
   already, it will do). Will return Fifo: ERROR=No TEC to set, if camera...
- GETTEMP:, Print current CCD temp on the command line
- CAPMODE:0-1, Set capture / focus mode 
- RUN:, This will start camera capture in current CAPMODE will retrun errors
  if camera is not connected or capture already running
- STOP: This will request stop current camera capture run. To kill last capture
  (if > 1000ms) just issue a second STOP request
- HOLD:0-1, Enable / disable a pause in the current camera capture run. Will 
  return error if no captureis running or camera is not connected
- AUDELA:0-1, Sets "audela" naming convention (save folder = ~/*current date*, 
  base name="image")
- IRIS:0-1, Add a variant to file numbering to be iris compatible
- DATEADD:0-1, Add current date to the file naming convention
- TIMEADD:0-1, Add current time to the naming convention
- FLTADD:0-1, Add current filter name to the naming convention
- FLTLIST:0-1, Prints the filter (pipe separated) list to the command line.
  FLTSET must use ordinal position (0 based) from this list.
  That is FLTSET:1 will set the second element
- FLTSET:number, Set active the nth element in the filters combobox
- ZEROCNT:0-1, Set a flag so that each camera capture run will restart file 
  numbering from 0
- BASEFOLDER:*path string*, Sets a custom folder to save captured frames
- BASENAME:*file base name* Sets a custom base name for captured frames
- OUTMODE:number, Sets the output mode (1:Fit, 2:Avi 3:Avi+Fit)
  Will eventually return Fifo: ERROR=Output mode out of range (1-3)
- CAMLIST:, Prints the camera (pipe separated) list to the command line.
  CAMSET must use ordinal position (0 based) from this list
  That is CAMSET:1 will set the second element
- CAMSET:number, Set active the nth element in the camera combobox.
  Will eventually return Fifo: ERROR=Camera index out of range (0-*max*)...
  Will also return error if a camera is connected already
- CAMCONNECT:0-1, Connect / disconnect selected camera
  Will return error if a camera is connected already and request connect
  Will return error if a camera is not connected and request disconnect
- CAMREFRESH:, Refresh camera list
- CAMRESET:, Reset currently selected camera
  Will return error if a camera is connected already, or if "none" is selected
- CAMOFFSET:0-255, Camera offset (0-255)
  Will return error if out of range
- CAMGAIN:0-100, Camera offset (0-100)
  Will return error if out of range
- CAMBINLIST:, Prints the camera bin (pipe separated) list to the command line.
  CAMBINSET must use ordinal position (0 based) from this list.
  That is CAMBINSET:1 will set the second element
- CAMBINSET:number, Set active the nth element in the bin combobox
  Will return error if out of range
- CAMSIZELIST:, Prints the capture size list to the command line.
  CAMSIZESET must use ordinal position (0 based) from this list.
  That is CAMSIZESET:1 will set the second element
- CAMSIZESET:number, Set active the nth element in the capture size combobox.
  Will return error if out of range
- CAMDSPDLIST:, Prints the download speed list to the command line
  CAMDSPDSET must use ordinal position (0 based) from this list
  That is CAMDSPDSET:1 will set the second element
- CAMDSPDSET:number, Set active the nth element in the download speed combobox
  Will return error if out of range
- CAMXMODLIST:, Prints the *camera mode* list to the command line
  CAMXMODSET must use ordinal position (0 based) from this list
  That is CAMDXMODSET:1 will set the second element
- CAMXMODSET:number, Set active the nth element in the *camera mode* combobox
  Will return error if out of range
- CAMAMPLIST:,Prints the amp mode list to the command line.
  CAMAMPSET must use ordinal position (0 based) from this list.
  That is CAMAMPSET:1 will set the second element
- CAMAMPSET:number,  Set active the nth element in the amp mode combobox
  Will return error if out of range
- CAMNRLIST:, Prints the noise reduction mode list to the command line
  CAMNRSET must use ordinal position (0 based) from this list
  That is CAMNRSET:1 will set the second element
- CAMNRSET:number, Set active the nth element in the filters combobox
  Will return error if out of range
- CAMDEPTHLIST: Prints the data depth list to the command line
  CAMDEPTHSET must use ordinal position (0 based) from this list
  That is CAMDEPTHSET:1 will set the second element
- CAMDEPTHSET:number, Set active the nth element in the data depth combobox
  Will return error if out of range
- CAMBAYERLIST:, Prints the bayer masks list to the command line.
  CAMBAYERSET must use ordinal position (0 based) from this list.
  That is CAMBAYERSET:1 will set the second element
- CAMBAYERSET:number, Set active the nth element in the filters combobox
  Will return error if out of range
- GETPRVWIDTH:, Print out preview image width
- GETPRVHEIGHT:, Print out preview image height
- GETDATADEPTH:, Print out current data depth
- SETSAVEJPG:0-1, Enable disable save additional preview jpg along with output
- GETPREVIEW:, Will save a preview image (as can be seen in program window)
  File name will be *fifopath*.jpg. Will answer with ACK or ERROR.
- SETROIPOS:roix roiy, Will set and enable a ROI for fwhm calculation.
  Will print out actually used coordinates (will chase for the bright spot 
  within the ROI square). Used coordinates are also printed to /tmp/roipos.txt
  Please note roix and roiy are relativ to the whole 1:1 image matrix.
- GETROIPOS:, will print out actually used coordinates and save to 
  /tmp/roipos.txt
- SETROISIZE: number, will set ROI size in pixels. Valid values: 8, 16, 32, 64.
  Will acknowledge change.
- HIDEROI:, will hide the ROI square (and stop calculations). 
  Will acknowledge change.
- GETFWHM:, will print out fwhm data (fwhm peak) on stdout and /tmp/fwhm.txt
- LOADFILE:filename-and-path, will load specified fit file. Program will report
  error if capture thread is running, if cfitsio can't load file, the pixel
  buffer can't be loaded or the file can't be found.

