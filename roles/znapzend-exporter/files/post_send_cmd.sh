#!/bin/bash

EXPORTER_HOST="localhost"
EXPORTER_PORT="9101"
DATASET_NAME="$1"
REMOTE_HOSTNAME="$2"

if [ $# -eq 0 ]; then
    echo "Dataset name required. ex) storage/dataset1"
    exit 1
fi

if [ -z $REMOTE_HOSTNAME ];then
    REMOTE_HOSTNAME="remote-host"
fi

/usr/bin/curl -sS $EXPORTER_HOST:$EXPORTER_PORT/postsend/$DATASET_NAME?SelfResetAfter=5m\&TargetHost=$REMOTE_HOSTNAME