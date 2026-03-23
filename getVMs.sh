#!/bin/bash

set -x
set -e

create_vm_script() {
	VM_SCRIPT=$1
	
	unameOut="$(uname -s)"
	case "${unameOut}" in
	    Linux*)     OSNAME=Linux;;
	    Darwin*)    OSNAME=Darwin;;
	    MSYS*|CYGWIN*|MINGW*)     OSNAME=Windows;;
	    *)          OSNAME="UNKNOWN:${unameOut}"
	esac

	VM_DIR=.
	VM_BINARY_NAME="Pharo"
	VM_BINARY_NAME_LINUX="pharo"
	VM_BINARY_NAME_WINDOWS="PharoConsole"

	if [ "$OSNAME" == "Windows" ]; then
	    PHARO_VM=`find $VM_DIR -name ${VM_BINARY_NAME_WINDOWS}.exe`
	elif [ "$OSNAME" == "Darwin" ]; then
	    PHARO_VM=`find $VM_DIR -name ${VM_BINARY_NAME}`
	elif [ "$OSNAME" == "Linux" ]; then
	    PHARO_VM=`ls $VM_DIR/${VM_BINARY_NAME_LINUX}`
	fi
	
	echo "#!/usr/bin/env bash" > $VM_SCRIPT
	echo '# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
DIR=`dirname "$DIR"`;
cd "$DIR"
DIR=`pwd`
cd - > /dev/null 
# disable parameter expansion to forward all arguments unprocessed to the VM
set -f
# run the VM and pass along all arguments as is' >> $VM_SCRIPT
	
	# make sure we only substite $PHARO_VM but put "$DIR" in the script
	echo -n \"\$DIR\"/\"$PHARO_VM\" >> $VM_SCRIPT
		
	# forward all arguments unprocessed using $@
	echo " \"\$@\"" >> $VM_SCRIPT
	
	# make the script executable
	chmod +x $VM_SCRIPT
}

rm -rf vms/pharo-10
rm -rf vms/pharo-12

mkdir -p vms/pharo-10
mkdir -p vms/pharo-12

ARCH=$(uname)

pushd vms/pharo-10
curl --progress-bar -o vm.zip https://files.pharo.org/vm/pharo-spur64-headless/$(uname -s)-$(uname -m)/latest10.zip
unzip vm.zip
create_vm_script "pharo"
popd

pushd vms/pharo-12
curl --progress-bar -o vm.zip https://files.pharo.org/vm/pharo-spur64-headless/$(uname -s)-$(uname -m)/latest12.zip
unzip vm.zip
create_vm_script "pharo"
popd