# Renesas RZ/V AI Applications
A snap package containing selected AI application examples from the
[Renesas RZ/V AI SDK](https://github.com/renesas-rz/rzv_ai_sdk), built for
the Renesas RZ/V2H platform.

## Overview
This repository provides the build configuration to package RZ/V AI Applications
as a [snap](https://snapcraft.io/). The snap is compiled/cross-compiled for
`arm64` (AArch64) and targets devices running Ubuntu 26.04 on the Renesas RZ/V2H
SoC. The DRP-AI TVM runtime is sourced from
[renesas-rz/rzv_drp-ai_tvm](https://github.com/renesas-rz/rzv_drp-ai_tvm), v2.5.1.

## Prerequisites
To run the snap on the RZ/V2H board, you need:
- Ubuntu 26.04 LTS Server image installed
- An HDMI monitor connected to the RZ/V2H
- A USB camera connected to the RZ/V2H
- Serial connection (UART) to run snap commands
- Ethernet connection to internet (to install Ubuntu Frame)

## Included Applications
| Snap command | Application | Description |
|---|---|---|
| `rzv-ai-applications.object-tracker USB` | Q01 Footfall Counter | Counts people passing through a scene using object tracking |
| `rzv-ai-applications.object-counter <vehicle\|animal\|coco> USB` | Q08 Object Counter | Counts objects in a scene |
| `rzv-ai-applications.object-detection` | R01 Object Detection | Detects and labels objects in a scene |


## Building
The snap is built with [Snapcraft](https://snapcraft.io/docs/snapcraft-overview)
and compiled/cross-compiled from an `amd64` or `arm64` host:

```bash
$ snapcraft pack
```

> **Note:** The snap is set to `grade: stable` and `confinement: strict`. The compression is set to `lzo` for faster launch time.

## Install and Run the AI Application Snap
The snap contains three applications from the Renesas AI SDK: `object-tracker`, `object-counter` and `object-detection`. `object-counter` itself has three different models to count different object types: vehicle, animal and coco (general).

Follow the following steps to deploy and test the snap on your device:

### Step 1: Install and Run Ubuntu Frame
On the RZ/V2H board, install and run Ubuntu Frame, which serves as a reliable and secure display server for embedded Linux devices.
```bash
$ sudo snap install ubuntu-frame
$ ubuntu-frame &
```

### Step 2: Install AI Application Snap

Install the AI Application snap you have just built:
```bash
$ sudo snap install --dangerous rzv-ai-applications_2.4_arm64.snap
```

### Step 3: Connect the Interfaces
This is a strictly confined snap, so you must create the following connections manually:
```bash
$ sudo snap connect rzv-ai-applications:camera :camera
$ sudo snap connect rzv-ai-applications:media-control :media-control
$ sudo snap connect rzv-ai-applications:wayland :wayland
$ sudo snap connect rzv-ai-applications:hardware-observe :hardware-observe
$ sudo snap connect rzv-ai-applications:drp-ai-plug rzv-ai-applications:drp-ai-slot
```

You can verify the connections with:
```bash
$ snap connections rzv-ai-applications
```

## Usage
Run any of the applications included in the snap. For example:

To run the object tracker:
```bash
rzv-ai-applications.object-tracker USB
```

To run the object counter with a specific model:
```bash
rzv-ai-applications.object-counter <vehicle|animal|coco> USB
```

To run the object detection:
```bash
rzv-ai-applications.object-detection
```


## License
This project is licensed under the GNU General Public License v3.0 — see the
[LICENSE](LICENSE) file for details.

The upstream AI SDK source code is provided by Renesas Electronics Corporation
and is subject to its own licensing terms. Refer to the [renesas-rz/rzv_ai_sdk](https://github.com/renesas-rz/rzv_ai_sdk)
repository for details.
