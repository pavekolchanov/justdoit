#!/bin/bash
# ssh="ssh -q -F ssh_config"

if [ -n "$1" ] && [ -n "$2" ]
then
	COMMAND="$1"
else
	echo "Usage: `basename $0` command servers|file"
	exit 1
fi

if [ -f "$2" ]; then
	parallel-ssh --inline --extra-args "-F ssh_config" --hosts "$2" "$COMMAND"
else
	HOSTS="${@:2}"
	parallel-ssh --inline --extra-args "-F ssh_config" --host "$HOSTS" "$COMMAND"
fi
