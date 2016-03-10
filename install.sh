# !/bin/bash

### Verify we are running with sudo OR root
if [[ $EUID -ne 0 ]]; then
	echo "Please run the installer as root!!!"
	exit 1
fi
echo "Verified root access..."
### Verify that mail in a box is installed.
if [ ! -f /etc/mailinabox.conf ]; then
	echo "Mail-In-A-Box is NOT installed, please install it from https://mailinabox.email"
	exit 1
fi
echo "Verified Mail-In-A-Box is installed..."
source functions.sh

### Start Script
echo "Preparing system to install lxc and dependencies..."

### Run some stuff here for updating and installing lxc...

## Check for updates first (Don't actually update, just want latest packages for lxc)

apt_update


### After checking updates, verify, twice, that the user wants to install.

read -p "Looks like the system is good to go, do you have a backup of MIAB? (y/N)" choice
case "$choice" in
	y|Y) echo "";;
	n|N) exit 0;;
	*) echo 	
		exit 0;;
esac

read -p "Are you sure you want to continue?" choice
case "$choice" in
	y|Y) echo "";;
	n|N) exit 0;;
	*) echo 
		exit 0;;
esac

### Now to the meat of this script, installing LXC!

echo "Installing LXC..."

# apt_install lxc
## Create a basic machine from an ubuntu template...
echo "Create first example machine..."
# hide_output lxc-create -t ubuntu -n "miablxc1"


echo "Looks like the installer completed, please be sure to note errors (if any)."
echo
echo "Good-Bye!"
echo 