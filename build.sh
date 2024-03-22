#!/usr/bin/env bash

set -ex

# Pharo Launcher build script
#
# We expect to have $PHARO and $VM parameter available in the environment
# $PHARO : 			version of the Pharo image, e.g. 61
# $VM : 			version of the VM, e.g. vm
# $ARCHITECTURE : 	targeted architecture 32 or 64 bits. Default will be 32.

# Script parameters
# $1: the target to run

function prepare_image() {
	case "$ARCHITECTURE" in
	        32) ARCH_PATH=
				;;
	        64 | arm64) ARCH_PATH="64/"
				;;
	        *) 	echo "Error! Architecture $ARCHITECTURE is not supported!"
				exit 1
				;;
	esac
	wget --quiet -O - get.pharo.org/$ARCH_PATH$PHARO | bash
	wget --quiet -O - get.pharo.org/$ARCH_PATH$VM$PHARO | bash
	echo "$PHARO" > 'pharo.version'

	./pharo Pharo.image save PharoLauncher --delete-old
	./pharo PharoLauncher.image --version > version.txt
	./pharo PharoLauncher.image eval --save "Metacello new baseline: 'PharoLauncher'; repository: 'gitlocal://src'; ignoreImage; onConflictUseIncoming; onWarning: [:ex | ex load]; load"
}

function run_tests() {
	rm -rf ~/Pharo # clean posssible remaining Pharo files
	./pharo --version
	ls -R pharo-vm
	./pharo PharoLauncher.image test --junit-xml-output "PharoLauncher-Tests-Functional.*"	
	run_shell_cli_tests
}

#this will run integration tests for CLI interface of Pharo Launcher
function run_shell_cli_tests() {
	pushd test
	for f in test*.sh; do
  		SHUNIT_COLOR=none bash "$f"
	done
	popd
}

function make_pharo_launcher_deloyed() {
	./pharo PharoLauncher.image eval --save "PhLDeploymentScript doAll"

	# Set the launcher version on Pharo 
	LAUNCHER_VERSION=$(eval 'git describe --tags --always')
	./pharo PharoLauncher.image eval --save "PhLAboutCommand version: '$LAUNCHER_VERSION'"  

        # Avoid to have PL core dir set to the slave location and having an outdated list of templates
	./pharo PharoLauncher.image eval --save \
		"PhLTemplateSources resetLauncherCoreDir.
		PharoLauncherApplication resetTemplateRepository.
		PhLDeploymentScript resetPharoLauncherIcebergRepositoryLocation"
}

function package_linux_version() {
	set_env
	OUTPUT_PATH=build
	RESOURCES_PATH=$OUTPUT_PATH/shared
	rm -f $OUTPUT_PATH; mkdir $OUTPUT_PATH
	mkdir $OUTPUT_PATH/icons; cp icons/pharo-launcher.png $OUTPUT_PATH/icons/
	cp linux/pharo-launcher-ui $OUTPUT_PATH/
	cp scripts/pharo-launcher.sh $OUTPUT_PATH/pharo-launcher
	mkdir $RESOURCES_PATH
	copy_current_stable_image_to $RESOURCES_PATH
	expand_all_templates $OUTPUT_PATH
	cp PharoLauncher.image $RESOURCES_PATH
    cp PharoLauncher.changes $RESOURCES_PATH
    cp Pharo*.sources $RESOURCES_PATH
	fetch_current_vm_to $OUTPUT_PATH
	# ensure the linux scripts are executable
	chmod +x "$OUTPUT_PATH/pharo-launcher" "$OUTPUT_PATH/pharo-launcher-ui" || true
	mv build pharo-launcher
	tar -cvf pharo-launcher-linux.tar pharo-launcher
}

function copy_mac_icon_files_to() {
	cd icons
	./build-icns.sh pharo-launcher.png PharoLauncher.iconset
	cd ..
	cp icons/PharoLauncher.icns $1
	cp icons/PharoImage.icns $1
	cp icons/PharoChanges.icns $1
	cp icons/PharoSources.icns $1
}

function package_mac_version() {
	set_env
	OUTPUT_PATH=PharoLauncher.app/Contents
	RESOURCES_PATH=$OUTPUT_PATH/Resources
	BIN_PATH=$OUTPUT_PATH/MacOS
	cp mac/Info.plist.template $OUTPUT_PATH/
	cp -R mac/MainMenu.nib $RESOURCES_PATH/English.lproj/
	expand_all_templates $OUTPUT_PATH
	copy_current_stable_image_to $RESOURCES_PATH
	copy_mac_icon_files_to $RESOURCES_PATH/
	mv mac-installer-background.png background.png
	fetch_current_mac_vm_to $(pwd)/$OUTPUT_PATH
	cp scripts/pharo-launcher.sh $BIN_PATH/pharo-launcher && chmod +x $BIN_PATH/pharo-launcher
	
	VERSION=$VERSION_NUMBER APP_NAME=PharoLauncher SHOULD_SIGN=false ./mac/build-dmg.sh
	local generated_dmg
	generated_dmg=$(echo *.dmg)
	mv "$generated_dmg" "PharoLauncher-$VERSION_NUMBER.dmg"
	generated_dmg=$(echo *.dmg)
	md5 "$generated_dmg" > "$generated_dmg.md5sum"	
}

function set_env() {
	DATE=$(date +%Y.%m.%d)
	case "$ARCHITECTURE" in
	        32) ARCH_SUFFIX="x86"
	        	;;
	        64) ARCH_SUFFIX="x64"
	        	;;
	        arm64) ARCH_SUFFIX="arm64"
	        	;;
	        *) 	echo "Error! Architecture $ARCHITECTURE is not supported!"
				exit 1
				;;
	esac
	VERSION_NUMBER="$VERSION-$ARCH_SUFFIX"
}

function copy_current_stable_image_to() {
	local DEST_PATH=${1:-.} # If no argument given, use current working dir
	local IMAGES_PATH=$DEST_PATH/images
	mkdir "$IMAGES_PATH"
	wget --progress=dot:mega -P "$IMAGES_PATH" https://files.pharo.org/image/stable/stable-64.zip
    mv "$IMAGES_PATH/stable-64.zip" "$IMAGES_PATH/pharo-stable.zip"
}

function fetch_current_vm_to() {
	local DEST_PATH=${1:-.} # If no argument given, use current working dir
	set_arch_path
	local LINUX_VM_PATH="pharo-vm-Linux-$VM_ARCH_PATH-stable.zip"
	test -f $LINUX_VM_PATH || wget --progress=dot:mega http://files.pharo.org/get-files/$PHARO/$LINUX_VM_PATH
  
	if [ -f "$LINUX_VM_PATH" ] ; then
	    unzip -q "$LINUX_VM_PATH" -d "$DEST_PATH/tmp"
		mkdir "$DEST_PATH/pharo-vm/"
	    mv "$DEST_PATH"/tmp/* "$DEST_PATH/pharo-vm/"
	else
	    echo "Warning: Cannot find Linux VM!"
	fi
}

function fetch_current_mac_vm_to() {
	# Only works for VM >= 90. If you need a VM < 90, you need to 
	# udpate this method to use either the old or new VM URL format (see zeroconf).
	local DEST_PATH=${1:-.} # If no argument given, use current working dir
	set_arch_path
	local VM_URL="http://files.pharo.org/get-files/$PHARO/pharo-vm-Darwin-${VM_ARCH_PATH}-stable.zip"
	local VM_TMP_PATH="$DEST_PATH/tmp"
	mkdir "$VM_TMP_PATH" && cd "$VM_TMP_PATH"
	VM_ZIP="${VM_TMP_PATH}/vm.zip"
	curl --silent --location --compressed --output "${VM_ZIP}" ${VM_URL}
	if [ -f "${VM_ZIP}" ] ; then
		unzip -q "${VM_ZIP}" -d "$VM_TMP_PATH"
	    # Ensuring bin and plugins
	    mv "$VM_TMP_PATH/Pharo.app/Contents/MacOS" "$DEST_PATH"
	    # Need to add this ugly '*' outside double-quotes to be able to copy the content of the folder (and not the folder itself) on linux
	    cp -R "$VM_TMP_PATH/Pharo.app/Contents/Resources/"* "$DEST_PATH/Resources"

	    cd -
	    rm -rf "$VM_TMP_PATH"
	else
	    echo "Warning: Cannot find Mac OS VM!"
	fi
}

function set_arch_path() {
	case "$ARCHITECTURE" in
	    64) export VM_ARCH_PATH="x86_64"
	        ;;
		arm64) export VM_ARCH_PATH="arm64"
	        ;;
	    *) 	echo "Error! Architecture $ARCHITECTURE is not supported!"
			export VM_ARCH_PATH=
			exit 1
			;;
	esac
}

function expand_all_templates() {
	local OUTPUT_PATH=$1
	local OPTION_WHEN=`date +"%B %d, %Y"`
	set_env
	find "$OUTPUT_PATH" -name "*.template" | while read FILE ; do
		sed \
			-e "s/%{NAME}/PharoLauncher/g" \
			-e "s/%{TITLE}/PharoLauncher/g" \
			-e "s/%{VERSION}/$VERSION-$DATE/g" \
			-e "s/%{WHEN}/$OPTION_WHEN/g" \
				"$FILE" > "${FILE%.*}"
		rm -f "$FILE"
	done
}

PHARO=${PHARO:=70}  # If PHARO not set, set it to 70.
VM=${VM:=signedVm}	# If VM not set, set it to signedVm.
ARCHITECTURE=${ARCHITECTURE:-'32'}	# If ARCHITECTURE not set, set it to 32 bits

SCRIPT_TARGET=${1:-all}
SHOULD_SIGN=${SHOULD_SIGN:-false}
echo "Running target $SCRIPT_TARGET"
echo "Using a Pharo$PHARO image and ${ARCHITECTURE}-bits $VM virtual machines from get-files."

case $SCRIPT_TARGET in
prepare)
  prepare_image
  ;;
test)
  run_tests
  ;;
make-deployed)
  make_pharo_launcher_deloyed
  ;;
linux-package)
  package_linux_version
  ;;
mac-package)
  package_mac_version "$SHOULD_SIGN"
  ;;
*)
  echo "No valid target specified! Exiting"
  ;;
esac
