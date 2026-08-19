#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: rzv-ai-applications.object-counter <COCO|animal|vehicle> <USB|MIPI>"
    exit 1
fi

# Derive the Wayland runtime dir from whoever launches the app instead of
# hardcoding uid 1000. On Ubuntu Server 26 the app runs as the 'ubuntu' user
# (uid 1000 -> /run/user/1000); on Ubuntu Core 26 it runs as root against the
# Frame service (uid 0 -> /run/user/0). Only fill it in if the session did not
# already provide a value.
: "${XDG_RUNTIME_DIR:=/run/user/$(id -u)}"
export XDG_RUNTIME_DIR

# Bridge Frame's Wayland socket into the snap's confined runtime dir.
# snapd remaps XDG_RUNTIME_DIR to /run/user/<uid>/snap.<name>, but Ubuntu
# Frame publishes its socket one level up at /run/user/<uid>/wayland-0.
# Link it in so the app (GTK) can find it. Assumes Frame is already running.
# WAYLAND_DISPLAY is provided by the app environment in snapcraft.yaml.
ln -sf "$(dirname "$XDG_RUNTIME_DIR")/$WAYLAND_DISPLAY" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"

cd $SNAP/usr/q08/bin && exec ./object_counter "$@"
