#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: rzv-ai-sdk-collection.object-tracker <USB|MIPI>"
    exit 1
fi

cd $SNAP/usr/q01/bin && exec ./object_tracker "$@"
