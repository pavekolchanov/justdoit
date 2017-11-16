#!/usr/bin/env bash

set -e

source "settings.env"

if [ -n "$1" ] && [ -n "$2" ]
then
	COMMAND="$1"
else
	echo "Usage: `basename $0` command servers|file"
	exit 1
fi

if [ -f "$2" ]; then
    # processed hosts file
    HOSTS="--hosts $2"
else
    # processed hosts args
    HOSTS="--host \"${@:2}\""
fi

parallel-ssh $OUTPUT --extra-args "-F $SSH_CONFIG" $HOSTS "$COMMAND"
