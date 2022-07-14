#!/usr/bin/env bash

set -ex

# Pharo Launcher build script
#
# We expect to have $PHARO and $VM parameter available in the environment
# $PHARO : 			version of the Pharo image, e.g. 61
# $VM : 			version of the VM, e.g. vm
# $ARCHITECTURE : 	targeted architecture 32 or 64 bits. Default will be 32.

# Script parameters
# $1: the target to run between prepare | test | user

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
	echo $PHARO > 'pharo.version'

	./pharo Pharo.image save PharoLauncher --delete-old
	./pharo PharoLauncher.image --version > version.txt
	./pharo PharoLauncher.image eval --save "Metacello new baseline: 'PharoLauncher'; repository: 'gitlocal://src'; ignoreImage; onConflictUseIncoming; load"
}

function run_tests() {
	./pharo PharoLauncher.image test --junit-xml-output "PharoLauncher.*"
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

function package_user_version() {
	./pharo PharoLauncher.image eval --save "PhLDeploymentScript doAll"

	# Set the launcher version on Pharo 
	LAUNCHER_VERSION=$(eval 'git describe --tags --always')
	./pharo PharoLauncher.image eval --save "PhLAboutCommand version: '$LAUNCHER_VERSION'"  

        # Avoid to have PL core dir set to the slave location and having an outdated list of templates
	./pharo PharoLauncher.image eval --save \
		"PhLTemplateSources resetLauncherCoreDir.
		PharoLauncherApplication resetTemplateRepository.
		PhLDeploymentScript resetPharoLauncherIcebergRepositoryLocation"

	# Create the platform-specific archives
	mkdir One
	cp PharoLauncher.image   One/Pharo.image
	cp PharoLauncher.changes One/Pharo.changes
	cp Pharo*.sources        One/
	cd One
	copy_current_stable_image
	cd ..

	set_env

	zip -9r PharoLauncher-user-$VERSION_NUMBER.zip PharoLauncher.image PharoLauncher.changes launcher-version.txt
}

function package_linux_version() {
	set_env
	rm -f pharo-build-scripts/platform/icons/*
	cp icons/pharo-launcher.png pharo-build-scripts/platform/icons/
	rm pharo-build-scripts/platform/templates/linux/%\{NAME\}.template
	cp linux/pharo-launcher-ui pharo-build-scripts/platform/templates/linux/pharo-launcher-ui.template
	cp script/pharo-launcher.sh pharo-build-scripts/platform/templates/linux/pharo-launcher.template
	EXECUTABLE_NAME=pharo-launcher-ui WORKSPACE=$(pwd) IMAGES_PATH=$(pwd)/One INPUT_SOURCES=$(ls $IMAGES_PATH/Pharo*.sources) ./pharo-build-scripts/build-platform.sh \
		 -i Pharo \
		 -o PharoLauncher \
		 -r $PHARO \
		 -v $VERSION-$DATE \
		 -t PharoLauncher \
		 -p linux
	
	mv PharoLauncher-linux.zip PharoLauncher-linux-$VERSION_NUMBER.zip
}

function prepare_mac_resources_for_build_platform_script() {
	rm -f pharo-build-scripts/platform/icons/*
	cd icons
	./build-icns.sh pharo-launcher.png PharoLauncher.iconset
	cd ..
	cp icons/PharoLauncher.icns pharo-build-scripts/platform/icons/
	rm -f pharo-build-scripts/platform/templates/mac/Contents/*
	cp mac/Info.plist.template pharo-build-scripts/platform/templates/mac/Contents/ 
}

function copy_mac_icon_files_to() {
	cp icons/PharoImage.icns $1
	cp icons/PharoChanges.icns $1
	cp icons/PharoSources.icns $1
}

function package_mac_version() {
	set_env
	local should_sign=${1:-false} # If no argument given, do not sign
	prepare_mac_resources_for_build_platform_script
	WORKSPACE=$(pwd) IMAGES_PATH=$(pwd)/One INPUT_SOURCES=$(ls $IMAGES_PATH/Pharo*.sources) ./pharo-build-scripts/build-platform.sh \
		-i Pharo \
		-o PharoLauncher \
		-r $PHARO \
		-v $VERSION-$DATE \
		-t PharoLauncher \
		-p mac
	unzip PharoLauncher-mac.zip -d .
	mv mac-installer-background.png background.png
	rm -f PharoLauncher.app/Contents/Resources/English.lproj/MainMenu.nib
	cp -R mac/MainMenu.nib PharoLauncher.app/Contents/Resources/English.lproj/
	cp script/pharo-launcher.sh PharoLauncher.app/Contents/MacOS/pharo-launcher
	chmod +x PharoLauncher.app/Contents/MacOS/pharo-launcher
	copy_mac_icon_files_to PharoLauncher.app/Contents/Resources/
	
	VERSION=$VERSION_NUMBER APP_NAME=PharoLauncher SHOULD_SIGN=false ./mac/build-dmg.sh
	local generated_dmg=$(echo *.dmg)
	mv "$generated_dmg" "PharoLauncher-$VERSION_NUMBER.dmg"
	generated_dmg=$(echo *.dmg)
	md5 "$generated_dmg" > "$generated_dmg.md5sum"	
}

function package_windows_version() {
	local should_sign=false # For now do not sign, we do not have anymore a valid certificate file  ${1:-false} # If no argument given, do not sign
	set_env
	WIN_VM_PATH=pharo-win-stable-signed.zip INPUT_SOURCES=One/$(basename $(ls One/Pharo*.sources)) bash ./pharo-build-scripts/build-platform.sh \
		-i Pharo \
		-o Pharo \
		-r $PHARO \
		-v $VERSION-$DATE \
		-t Pharo \
		-p win
	unzip Pharo-win.zip -d .
	
	if [ "$should_sign" = true ] ; then
		openssl aes-256-cbc -k "${PHARO_CERT_PASSWORD}" -in signing/pharo-windows-certificate.p12.enc -out pharo-windows-certificate.p12 -d
		local signtool='C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe'
		"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} Pharo/Pharo.exe
		"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} Pharo/PharoConsole.exe
	fi

	local installerVerion=bleedingEdge
	if [ "$IS_RELEASE" = true ] ; then
		# only get version number, not arch
		# uses bash parameter expansion using a pattern. 
		#   see https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
		installerVerion=${VERSION_NUMBER%-*}
	fi
	OS_NAME=$(uname -s)
	OS_NAME=${OS_NAME:0:6}
	if [[ "$OS_NAME" = "CYGWIN" ]]
	then
   		# Cygwin specific stuff
   		CMD="cygstart --wait cmd"
	else
   		CMD=cmd
	fi
	INSTALLER_VERSION=$installerVerion $CMD /c windows\\build-launcher-installer.bat
	if [ "$should_sign" = true ] ; then
		"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} pharo-launcher-${VERSION}.msi
		rm pharo-windows-certificate.p12
	fi
}

function set_env() {
	DATE=$(date +%Y.%m.%d)
	case "$ARCHITECTURE" in
	        32) ARCH_SUFFIX="x86"
	        	;;
	        64) ARCH_SUFFIX="x64"
				export ARCH=64
	        	;;
	        arm64) ARCH_SUFFIX="arm64"
				export ARCH=arm64
	        	;;
	        *) 	echo "Error! Architecture $ARCHITECTURE is not supported!"
				exit 1
				;;
	esac
	VERSION_NUMBER="$VERSION-$ARCH_SUFFIX"
}

function copy_current_stable_image() {
	local IMAGES_PATH="images"
	mkdir "$IMAGES_PATH"
	wget -P $IMAGES_PATH https://files.pharo.org/image/stable/stable-64.zip
    mv "$IMAGES_PATH/stable-64.zip" "$IMAGES_PATH/pharo-stable.zip"
}

PHARO=${PHARO:=70}  	# If PHARO not set, set it to 70.
VM=${VM:=signedVm}	# If VM not set, set it to signedVm.
ARCHITECTURE=${ARCHITECTURE:-'32'}		# If ARCH not set, set it to 32 bits

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
user)
  package_user_version
  ;;
win-package)
  package_windows_version $SHOULD_SIGN
  ;;
mac-package)
  package_mac_version $SHOULD_SIGN
  ;;
linux-package)
  package_linux_version
  ;;
all)
  prepare_image && run_tests && package_user_version \
  	&& package_linux_version
  ;;
*)
  echo "No valid target specified! Exiting"
  ;;
esac
