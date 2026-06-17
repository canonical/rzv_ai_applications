#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: rzv-ai-applications.object-counter <COCO|animal|vehicle> <USB|MIPI>"
    exit 1
fi

cd $SNAP/usr/q08/bin && exec ./object_counter "$@"
