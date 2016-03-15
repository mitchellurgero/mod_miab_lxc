#!/bin/bash

### Verify we are running with sudo OR root
if [[ $EUID -ne 0 ]]; then
	echo "Please run the installer as root!!!"
	exit 1
fi
echo "Verified root access..."
### Verify that mail in a box is installed.
if [  -f /etc/mailinabox.conf ]; then
	echo "Mail-In-A-Box is NOT installed, please install it from https://mailinabox.email"
	exit 1
fi
echo "Verified Mail-In-A-Box is installed..."
source functions.sh
echo "Preparing system and scripts..."
## Check for updates first (Don't actually update, just want latest packages for lxc)
apt_update

### Popup warning
echo "Installing script dependencies..."
apt_install dialog

message_box "Warning" "This modification will install and modify system files. Please be sure to have a proper backup. This modification is NOT officially supported in any means by @JoshData or Any mail-in-a-box creators."
message_box "Warning Pt. 2" "If you are sure you want to continue, press enter. Otherwise, press ctrl + c to cancel now."
echo
echo

echo
echo
echo "Ok, you have been warned 4 times. We will continue with the installation of lxc and modded template files for the Admin Dashboard..."
### Now to the meat of this script, installing LXC!
echo

echo "Installing LXC..."

#apt_install lxc


## Create a basic machine from an ubuntu template...
echo "Create first example machine..."
## Chack to make sure the machine does not exist...
if [ -f /var/lib/lxc/miablxc1/config ]; then
	echo "Example lxc already exists! Not overwriting the current lxc."
	echo "Looks like the installer completed, please be sure to note errors (if any)."
	echo 
	exit 0
fi


#hide_output lxc-create -t ubuntu -n "miablxc1"
echo
echo
echo "The default username is: ubuntu, and the default password is: ubuntu."
echo "Please change this when you login to the lxc to prevent any security risk!"
echo "You may use the new vmctl command to manage Linux Containers, or use the Admin Dashboard."
echo

echo "Installing modded template files for MIAB..."

### Here will eventually be where modded files are copied over to MIAB directories. ###

input_box "Where is your home directory?" "I need to know where you initially ran the mail-in-a-box installer. Please input the FULL path here. This is usually under your home folder '/home/<username>'. DO NOT PUT THE PATH TO THE 'mailinaboxfolder' just the path to the root of where the folder is stored." "/home/<user-name>" HOME_FLDR
echo
echo
echo
echo "Folder selected: $HOME_FLDR"
if [ ! -f "$HOME_FLDR/mailinabox/management/templates/index.html" ]; then
	echo
	echo "Could not find the Mail-In-A-Box setup/root directory! Please use the right path!"
	echo
	exit 1
fi
### MIAB is installed, now to copy over the template file to MIAB directory!

hide_output cp ./templates/lxc.html "$HOME_FLDR/mailinabox/management/templates/lxc.html"

### Copy over Python management scripts for lxc commands.

hide_output cp ./management/lxc.py "$HOME_FLDR/mailinabox/management/lxc.py"


### End Script
echo
echo "Looks like the installer completed, please be sure to note errors (if any)."
echo
exit 0