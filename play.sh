#!/bin/bash

function pssh_trap_handler()
{
	MYSELF="$0"
	LASTLINE="$1"            # argument 1: last line of error occurence
	LASTERR="$2"             # argument 2: error code of last command
	echo "${MYSELF}: line ${LASTLINE}: exit status of last command: ${LASTERR}"
	if [ "$LASTERR" -eq 1 ]; then
		echo "1      Miscellaneous error"
	elif [ "$LASTERR" -eq 2 ]; then
		echo "2      Syntax or usage error"
	elif [ "$LASTERR" -eq 3 ]; then
		echo "3      At least one process was killed by a signal or timed out."
	elif [ "$LASTERR" -eq 4 ]; then
		echo "4      All processes completed, but at least one ssh process reported an error (exit status 255)."
	elif [ "$LASTERR" -eq 5 ]; then
		echo "5      There were no ssh errors, but at least one remote command had a non-zero exit status."
	fi
}

if [ -n "$1" ] && [ -n "$2" ]
then
    LOCAL_SCRIPT="$1"
    REMOTE_SCRIPT=$( basename "$1" )
else
    echo "Usage: `basename$0` script servers|file"
    exit 1
fi

trap 'pssh_trap_handler ${LINENO} $?' ERR

if [ -f "$2" ]; then
	# processed hosts file
	HOSTARG="--hosts $2"
else
	# processed hosts args
	#HOSTS="${@:2}"
	HOSTARG="--host \"${@:2}\""
fi

parallel-scp --extra-args "-F ssh_config" $HOSTARG "$LOCAL_SCRIPT" "/tmp/$REMOTE_SCRIPT" > /dev/null && \
parallel-ssh --inline --extra-args "-F ssh_config" $HOSTARG "chmod +x /tmp/$REMOTE_SCRIPT ; /tmp/$REMOTE_SCRIPT" && \
parallel-ssh --extra-args "-F ssh_config" $HOSTARG "rm /tmp/$REMOTE_SCRIPT" > /dev/null
