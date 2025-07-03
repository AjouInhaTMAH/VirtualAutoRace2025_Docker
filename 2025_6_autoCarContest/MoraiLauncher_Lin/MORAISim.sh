#!/bin/sh
echo "---------- MORAI Simulator ----------"

# Check if proper files for hotplug or udev package are installed
# Either one is required to use a usb dongle 
USB_PATH_HOTPLUG=/etc/hotplug/usb
HOTPLUG_OK=0
if [ -d $USB_PATH_HOTPLUG ]
then
	if [ -s $USB_PATH_HOTPLUG/keylok ] && [ -s $USB_PATH_HOTPLUG/keylok.usermap ]
	then
		HOTPLUG_OK=1
	fi
fi

USB_PATH_UDEV=/etc/udev/rules.d
UDEV_OK=0
if [ -d $USB_PATH_UDEV ]
then
	if [ -s $USB_PATH_UDEV/z95_keylok.rules ]
    then
    	UDEV_OK=1
    fi
fi

echo "[INFO] HOTPLUG_OK :" $HOTPLUG_OK
echo "[INFO] UDEV_OK    :" $UDEV_OK


# If no files are installed, install
if [ $HOTPLUG_OK -eq 0 ] && [ $UDEV_OK -eq 0 ]
then
	FILE_FULLNAME=$(echo \"$0\" | xargs readlink -f)
	FILE_FULLDIR=$(dirname "$FILE_FULLNAME")
	#echo "[INFO] This might be the first time running. Required files will be installed."
	#sudo /bin/sh "$FILE_FULLDIR/Install/keylok_install"
	#echo "[INFO] The installation finished."
else
	echo "[INFO] Required files are already installed."
fi

# Kvaser CAN
# Create Simbolic link

KVASER_DRIVER_SOFILE=/usr/lib/libcanlib.so

if [ -f "$KVASER_DRIVER_SOFILE" ]; then
	echo "[INFO] Create simbolic link - canlib32"
	sudo ln -s /usr/lib/libcanlib.so /usr/lib/canlib32
else
	echo "[INFO] Not exists libcanlib.so file"
fi

# Run the simulator
echo "[INFO] Launcher will start running..."
SIMULATOR_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
SIMULATOR_PROJECT_ROOT=$(dirname "$SIMULATOR_TRUE_SCRIPT_NAME")
#chmod +x $SIMULATOR_PROJECT_ROOT/MoraiLauncher_Lin.x86_64
#chmod +x $SIMULATOR_PROJECT_ROOT/setPermission.sh

`$SIMULATOR_PROJECT_ROOT/MoraiLauncher_Lin.x86_64`


