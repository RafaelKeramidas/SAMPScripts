##
# SA-MP Install script
#
# @Author	Rafael 'R@f' Keramidas
# @Date		2nd July 2012
# @Comment	Lynx package needed
##

#!/bin/bash

# Command to get the download link for the sa-mp linux server archive (Lynx required !).
LINK=`lynx -dump "http://files.sa-mp.com/?C=M;O=D" | awk '($2 ~ /\.tar\.gz/){print $2}' | head -1`
# Get the archive name (by removing "http://files.sa-mp.com/".
ANAME=`echo $LINK | sed 's/.\{23\}//'`

if [ -z $1 ]
then
	echo "Usage: $0 [SERVERNAME]"
else
	echo "Starting install..."
	# If the download directory does not exist.
	if [ ! -d $DLDIR ]
	then
		# Create the download directory.
		mkdir $DLDIR
	fi
	# Go to the download directory.
	cd $DLDIR
	# Download the archive.
	wget $LINK
	# Untar the archive.
	tar -zxf $ANAME
	# Removing the archive.
	rm $ANAME
	# Move and rename the samp directory
	mv samp03 $1
	# Go to the samp directory
	cd $1
	# Rename the server executable
	mv samp03svr "samp03svr$1"
	echo "Installation finished !"
fi
