#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

# get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# get all .sh files that dont start with "_", recursively
FILES=$(find $DIR -type f -name "*.sh" ! -name "_*")

# run them all
for f in $FILES
do
  echo "Running $f"
  bash $f
done


read -p "A reboot is necessary for your changes to take effect. \
Would you like to reboot now? (y/N): " \
confirmation

reboot
