#!/bin/bash

if [ "$#" -ne 0 ]; then
    echo "Usage: rzv-ai-applications.object-detection"
    exit 1
fi

cd $SNAP/usr/r01/bin && exec ./object_detection "$@"
