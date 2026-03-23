#!/bin/bash

set -x 

SCRIPT_DIR=$(readlink -f $(dirname -- "${BASH_SOURCE[0]}"))

rebench -D $SCRIPT_DIR/../bloc.rebench
rebench -D $SCRIPT_DIR/../pharo.rebench
rebench -D $SCRIPT_DIR/../cormas.rebench
rebench -D $SCRIPT_DIR/../dataFrame.rebench
rebench -D $SCRIPT_DIR/../honeyGinger.rebench
rebench -D $SCRIPT_DIR/../microdown.rebench

python $SCRIPT_DIR/generatePlots.py
