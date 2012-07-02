##
# SA-MP Start/Stop Script
#
# @Author	Rafael 'R@f' Keramidas
# @Date		2nd July 2012
# @Comment	Don't run your server with root !
##

#!/bin/bash

# Variables (CONFIG)
DIR="/home/samp" 			# SA-MP Server directory
EXEC="samp03svr"			# SA-MP Server executable
SCREENNAME="samp" 			# Screen name
DESC="SA-MP Test Server"	# Description

# Functions
function startServer {
	if [ -d $DIR ]; then
		cd $DIR
		if [ -f $EXEC ]; then
			screen -dmS $SCREENNAME ./$EXEC
			echo "$DESC started !"
		else
			echo "Error: SA-MP executable ($EXEC) not found !"
		fi
	else
		echo "Error: SA-MP directory ($DIR) not found !"
	fi
}

function stopServer {
	CHECK=`ps u -C $EXEC | grep -vc USER`
	if [ $CHECK -eq 0 ]; then
		echo "$DESC is currently not running."
	else
		killall $EXEC
		echo "$DESC stopped !"
	fi
}

function serverStatus {
	CHECK=`ps u -C $EXEC | grep -vc USER`
	if [ $CHECK -eq 0 ]; then
		echo "$DESC is currently not running."
	else 
		echo "$DESC is running."
	fi
}

# Main
case "$1" in
	start)
		startServer
		;;

	stop)
		stopServer
		;;

	restart)
		stopServer
		sleep 1
		startServer
		;;

	status)
		serverStatus
		;;


	*)
		echo "Usage: $0 {start|stop|restart|status}"
		exit 1
		;;
		
esac
exit