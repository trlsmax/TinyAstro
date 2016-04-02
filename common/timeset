#!/bin/bash
##
#  timeset- A script to configure the system date and time on Linux
#  Copyright (C) 2013-2015 Aaditya Bagga (aaditya_gnulinux@zoho.com)
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  any later version.
#
#  This program is distributed WITHOUT ANY WARRANTY;
#  without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##

VER=1.6 # Version

# Gettext internationalization
export TEXTDOMAIN="timeset"
export TEXTDOMAINDIR="/usr/share/locale"

# Colors
BLUE="\e[1;34m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
RED="\e[1;31m"
BOLD="\e[1m"
CLR="\e[0m"

# Functions related to input and output
msg() {
	# msg $msg
	local msg=$1
	gettext "$msg"
	echo
}

msg_bold() {
	# msg_bold $msg
	local msg=$1
	echo -ne "$BOLD"
	gettext "$msg"
	echo -e "$CLR"
}

msg_green() {
	# msg_green $msg
	local msg=$1
	echo -ne "$GREEN"
	gettext "$msg"
	echo -e "$CLR"
}

pause_for_input() {
	echo -ne "$BOLD" "$(gettext 'Press Enter to continue...')" "$CLR"
	read
}

# Run as root
if [ "$EUID" -ne 0 ] ; then
	msg 'Root priviliges required.'
	exit 1
fi

# Check if timedatectl is present and systemd is running
if [[ -f /usr/bin/timedatectl ]] && [[ $(pidof systemd) ]]; then
	SYSTEMD=1
else
	SYSTEMD=0
fi

# Check if openrc is running
if [ -e /run/openrc ]; then
	OPENRC=1
else
	OPENRC=0
fi

# Distro specifc
[ -e /etc/os-release ] && . /etc/os-release

if [[ $NAME = Slackware ]] && [[ $(pidof init) ]] ; then
	SLACKWARE=1
else
	SLACKWARE=0
fi

# Command List
if [ "$SYSTEMD" -eq 1 ]; then
	# Systemd specific commands
	get_time() {
		timedatectl status
	}
	list_timezones() {
		timedatectl list-timezones
	}
	set_timezone() {
		timedatectl set-timezone "$1" && echo "$(gettext 'Timezone set to') $1"
	}
	set_hwclock_local="timedatectl set-local-rtc 1"
	set_hwclock_utc="timedatectl set-local-rtc 0"
	set_time() {
		timedatectl set-time "$1"
	}
else
	# Generic Linux commands
	get_time() {
		echo -e "$(date) ($(date +%z))" "$BOLD" "<-Local time" "$CLR" "\n$(date -u) (UTC)" "$BOLD" "  <-UTC" "$CLR"
	}
	list_timezones() {
		find -L /usr/share/zoneinfo/posix -mindepth 2 -type f -printf "%P\n" | sort | less
	}
	set_timezone() {
		if [ -f "/usr/share/zoneinfo/posix/$1" ]; then
			ln -sf "/usr/share/zoneinfo/posix/$1" /etc/localtime && echo "$(gettext 'Timezone set to') $1"
		else
			msg 'Wrong timezone entered.'
		fi
	}
	set_hwclock_local() {
		hwclock --systohc --localtime
		# openrc specific
		if [ "$OPENRC" -eq 1 ]; then
			# modify /etc/conf.d/hwclock if it exists
			if [ -e /etc/conf.d/hwclock ]; then
				sed -i "s/clock=.*/clock=\"local\"/" /etc/conf.d/hwclock
			fi
		fi
	}
	set_hwclock_utc() {
		hwclock --systohc --utc
		# openrc specific
		if [ "$OPENRC" -eq 1 ]; then
			# modify /etc/conf.d/hwclock if it exists
			if [ -e /etc/conf.d/hwclock ]; then
				sed -i "s/clock=.*/clock=\"UTC\"/" /etc/conf.d/hwclock
			fi
		fi
	}
	set_time() {
		if [[ $1 = [0-9]*:[0-9]* ]] || [[ $1 = [0-9]*-[0-9]*-[0-9]* ]] || [[ $1 = "[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*" ]] || [[ $1 = "[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*:[0-9]*" ]]; then
			date -s "$1"
		else
			msg 'Time not entered correctly.'
		fi
	}
fi

# Distro / init specific commands
set_ntp () {
	# set_ntp $ntch
	local ntch=$1
	if [ "$SYSTEMD" -eq 1 ]; then
		timedatectl set-ntp "$ntch"
	fi
	if [ "$OPENRC" -eq 1 ]; then
		if [ -f /etc/init.d/ntpd ]; then
			if [ "$ntch" -eq 1 ]; then
				rc-update add ntpd
			elif [ "$ntch" -eq 0 ]; then
				rc-update del ntpd
			else
				msg 'Incorrect choice.'
			fi
		else
			msg 'ntpd service not found.'
		fi
	elif [ "$SLACKWARE" -eq 1 ]; then
		if [ -f /etc/rc.d/rc.ntpd ]; then
			if [ "$ntch" -eq 1 ]; then
				chmod -v +x /etc/rc.d/rc.ntpd
			elif [ "$ntch" -eq 0 ]; then
				chmod -v -x /etc/rc.d/rc.ntpd
			else
				msg 'Incorrect choice.'
			fi
		else
			msg '/etc/rc.d/rc.ntpd not found.'
		fi
	else
		msg 'For this to work the ntp daemon (ntpd) needs to be installed.'
		msg 'Furthur you may need need to edit /etc/ntp.conf (or similar) file, and then enable the ntp daemon to start at boot.'
		msg 'This feature is distribution specific and not handled by this script.'
	fi
}

# Menu

while (true); do
    # Run infinte loop for menu, till the user quits.
    clear
    echo "----------------------------------------------------------------------"
    echo -e "$BLUE" " $(gettext 'TimeSet - Configure system date and time')" "$CLR"
    echo "----------------------------------------------------------------------"
    echo 
    echo -e "$YELLOW" '[1]' "$CLR $BOLD" "$(gettext 'Show current date and time configuration')" "$CLR"
    echo -e "$YELLOW" '[2]' "$CLR $BOLD" "$(gettext 'Show known timezones (press q to return to menu)')" "$CLR"
    echo -e "$YELLOW" '[3]' "$CLR $BOLD" "$(gettext 'Set system timezone')" "$CLR"
    echo -e "$YELLOW" '[4]' "$CLR $BOLD" "$(gettext 'Synchronize time from the network (NTP)')" "$CLR"
    echo -e "$YELLOW" '[5]' "$CLR $BOLD" "$(gettext 'Choose whether NTP is enabled or not')" "$CLR"
    echo -e "$YELLOW" '[6]' "$CLR $BOLD" "$(gettext 'Control whether hardware clock is in UTC or local time')" "$CLR"
    echo -e "$YELLOW" '[7]' "$CLR $BOLD" "$(gettext 'Show the time and settings for the hardware clock')" "$CLR"
    echo -e "$YELLOW" '[8]' "$CLR $BOLD" "$(gettext 'Synchronize hardware clock to system time')" "$CLR"
    echo -e "$YELLOW" '[9]' "$CLR $BOLD" "$(gettext 'Synchronize system time to hardware clock time')" "$CLR"
    echo -e "$YELLOW" '[10]' "$CLR$BOLD" "$(gettext 'Set system time manually')" "$CLR"
    echo -e "$YELLOW" '[11]' "$CLR$BOLD" "$(gettext 'About')" "$CLR"
    echo 
    echo -e "$RED" "[q]   $(gettext 'Exit/Quit')\n" "$CLR"
    echo "======================================================================"
    echo -ne "$GREEN" "$(gettext 'Enter your choice') [1-10,q]:" "$CLR"
    
    read -e choice
    if [ ! "$choice" ]; then 
	    choice=0 
    fi

# Commands

    case $choice in
      1)
	msg_bold 'Current date and time'
	get_time 
	pause_for_input
	;;
      
      2) 
	list_timezones ;;
      
      3) 
	echo -ne "$BOLD" "$(gettext 'Enter the timezone (It should be like Continent/City):')" "$CLR"
	read -e tz; set_timezone "$tz"
	pause_for_input
	;;

      4) 
	msg_green 'Synchronizing time from the network.'
	msg_green 'NTP should be installed for this to work.'
	msg 'Please wait a few moments while the time is being synchronised...'
	if [ -e /usr/sbin/ntpdate ]; then
		/usr/sbin/ntpdate -u 0.pool.ntp.org
	else
		msg 'ntpdate not found.'
	fi
	pause_for_input
	;;

      5)
	# Enable the NTP daemon
	msg_green 'If NTP is enabled the system will periodically synchronize time from the network.'
	echo -ne "$BOLD" "$(gettext 'Enter 1 to enable NTP and 0 to disable NTP:')" "$CLR"
	read ntch
	set_ntp "$ntch"
	pause_for_input
	;;

      6) 
	echo -ne "$BOLD" "$(gettext 'Enter 0 to set hardware clock to UTC and 1 to set it to local time:')" "$CLR"
	read hwc
	if [[ $hwc = 1 ]]; then
		$set_hwclock_local
		msg 'Hardware clock set to local time.'
	elif [[ $hwc = 0 ]]; then
		$set_hwclock_utc
		msg 'Hardware clock set to UTC.'
	else 
		msg 'Incorrect choice entered.'
	fi  
	pause_for_input
	;;

      7) 
	# Display complete info for hardware clock
	/sbin/hwclock --debug 
	pause_for_input
	;;

      8)
	# Set system time from hardware clock
	/sbin/hwclock --systohc
	pause_for_input
	;;
      
      9)
	# Set hardware clock to system time.
	/sbin/hwclock --hctosys
	pause_for_input
	;;

      10)
	# Set time manually
	msg_green 'Enter the time.'
	msg_green 'The time may be specified in the format 2012-10-30 18:17:16'
	msg_green 'Only hh:mm can also be used.'
	echo -ne "$BOLD" "$(gettext 'Enter the time:')" "$CLR"
	read -e time; set_time "$time" 
	pause_for_input
	;;

      11)
	# About
	echo "Timeset version $VER"
	[[ $SYSTEMD -eq 1 ]] && echo "Using init systemd"
	[[ $OPENRC -eq 1 ]] && echo "Using init OpenRC"
	pause_for_input
	;;

      q) exit 0 ;;

      0)
	# Do nothing
      	;;

      *) 
	echo -e "$RED" "$(gettext 'Oops!!! Please a valid choice!')" "$CLR"
	pause_for_input
	;;
    esac
    # Case ends
done
# Menu loop ends

exit $?
