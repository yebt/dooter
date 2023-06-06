#!/bin/bash

##
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR="dots"
##
DOTS_DIR="$SCRIPT_DIR/../../$DOTS_DIR"
##
cd $DOTS_DIR

ln -s $(pwd)/* ~/.config/
