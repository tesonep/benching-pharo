#!/bin/bash

set -x 

rebench -D bloc.rebench
rebench -D pharo.rebench
rebench -D cormas.rebench
rebench -D dataFrame.rebench
rebench -D honeyGinger.rebench
rebench -D microdown.rebench

python ./scripts/generatePlots.py
