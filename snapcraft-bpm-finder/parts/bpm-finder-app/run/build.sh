#!/bin/bash
set -euo pipefail
source /mnt/c/Users/nazza/Desktop/bpm-finder/packages/snapcraft-bpm-finder/parts/bpm-finder-app/run/environment.sh
set -x
cp --archive --link --no-dereference . "/mnt/c/Users/nazza/Desktop/bpm-finder/packages/snapcraft-bpm-finder/parts/bpm-finder-app/install"
