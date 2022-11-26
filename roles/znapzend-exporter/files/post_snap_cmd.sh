#!/bin/bash

EXPORTER_HOST="localhost"
EXPORTER_PORT="9101"
DATASET_NAME=$1
REMOTE_HOSTNAME="remote-host"

if[ $# -eq 0 ]; then
    echo "Dataset name required. ex) storage/dataset1"
    exit 1
fi

echo "/usr/bin/curl -sS "$EXPORTER_HOST":"$EXPORTER_PORT"/postsnap/"$DATASET_NAME"
