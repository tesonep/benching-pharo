#!/bin/bash

# Cloning PharoVeritasBenchSuite

set -x 
set -e

git clone https://github.com/tesonep/PharoVeritasBenchSuite.git

# Create Data output directory
mkdir data

# Create bloc image
mkdir bloc
pushd bloc
../PharoVeritasBenchSuite/scripts/installBlocImage.sh
popd 

# Create clean Pharo14 image
mkdir pharo
pushd pharo
wget -O - get.pharo.org/64/140 | bash
popd

# Create other Veritas images
mkdir veritas
pushd veritas
../PharoVeritasBenchSuite/scripts/installPharoImages.sh
popd

# Get benchmarked vms
./scripts/getVMs

# Prepare output scripts
mkdir images