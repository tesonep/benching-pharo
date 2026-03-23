#!/bin/bash

set -x 

rebench -D bloc.rebench

pushd pharo
rebench -D ../pharo.rebench
popd

pushd veritas
rebench -D ../cormas.rebench
rebench -D ../dataFrame.rebench
rebench -D ../honeyGinger.rebench
rebench -D ../microdown.rebench
popd

pushd plots
python script.py
popd