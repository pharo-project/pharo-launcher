#!/usr/bin/env bash

set -ex

# Pharo Launcher build script
#
# We expect to have $PHARO and $VM parameter available in the environment
# $PHARO : 			version of the Pharo image, e.g. 61
# $VM : 			version of the VM, e.g. vm
# $ARCHITECTURE : 	targeted architecture 32 or 64 bits. Default will be 32.
# $VERSION: 		the Metacello version of PharoLauncher to load

# Script parameters
# $1: the target to run between prepare | test | developer | user
# $2: a value for $VERSION (optional)

function prepare_image() {
	case "$ARCHITECTURE" in
	        32) ARCH_PATH=
				;;
	        64) ARCH_PATH="64/"
				;;
	        *) 	echo "Error! Architecture $ARCHITECTURE is not supported!"
				exit 1
				;;
	esac
	wget --quiet -O - get.pharo.org/$ARCH_PATH$PHARO+$VM | bash

	./pharo Pharo.image save PharoLauncher --delete-old
	./pharo PharoLauncher.image --version > version.txt

	local REPO=http://smalltalkhub.com/mc/Pharo/PharoLauncher/main
	./pharo PharoLauncher.image config $REPO ConfigurationOfPharoLauncher --install=$VERSION
}

function run_tests() {
	./pharo PharoLauncher.image test --junit-xml-output "PharoLauncher.*"	
}

function package_developer_version() {
	./pharo PharoLauncher.image eval --save "PhLDirectoryBasedImageRepository location"
	./pharo PharoLauncher.image eval '(MBConfigurationRoot current configurationInfoFor: ConfigurationOfPharoLauncher) version versionNumber' > launcher-version.txt
	set_env
	zip -9r PharoLauncher-developer-$VERSION_NUMBER.zip PharoLauncher.image PharoLauncher.changes launcher-version.txt
}

function package_user_version() {
	./pharo PharoLauncher.image eval --save "PhLDeploymentScript doAll"
	# Faster the startup of the launcher image
	./pharo PharoLauncher.image eval --save ""

	# Create the platform-specific archives
	mkdir One
	cp PharoLauncher.image   One/Pharo.image
	cp PharoLauncher.changes One/Pharo.changes
	mkdir One/win
	cp ProcessWrapperPlugin.dll One/win/
	cd One
	get_pharo_sources_version $PHARO
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
	cp linux/pharo-launcher pharo-build-scripts/platform/templates/linux/pharo-launcher.template
	EXECUTABLE_NAME=pharo-launcher WORKSPACE=$(pwd) IMAGES_PATH=$(pwd)/One ./pharo-build-scripts/build-platform.sh -i Pharo -o PharoLauncher -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t PharoLauncher -p linux
	
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

function package_mac_version() {
	set_env
	prepare_mac_resources_for_build_platform_script
	WORKSPACE=$(pwd) IMAGES_PATH=$(pwd)/One ./pharo-build-scripts/build-platform.sh -i Pharo -o PharoLauncher -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t PharoLauncher -p mac
	unzip PharoLauncher-mac.zip -d .
	mv mac-installer-background.png background.png
	
	VERSION=$VERSION_NUMBER APP_NAME=PharoLauncher ./mac/build-dmg.sh
	local generated_dmg=$(echo *.dmg)
	mv "$generated_dmg" "PharoLauncher-$VERSION_NUMBER.dmg"
	generated_dmg=$(echo *.dmg)
	md5 "$generated_dmg" > "$generated_dmg.md5sum"	
}

function package_windows_version() {
	set_env
	bash ./pharo-build-scripts/build-platform.sh -i Pharo -o Pharo -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t Pharo -p win
	unzip Pharo-win.zip -d .
	
	openssl aes-256-cbc -k "${PHARO_CERT_PASSWORD}" -in signing/pharo-windows-certificate.p12.enc -out pharo-windows-certificate.p12 -d
	local signtool='C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe'
	"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} Pharo/Pharo.exe
	"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} Pharo/PharoConsole.exe

	INSTALLER_VERSION=${VERSION} cmd /c windows\\build-launcher-installer.bat
	"$signtool" sign //f pharo-windows-certificate.p12 //p ${PHARO_CERT_PASSWORD} pharo-launcher-${VERSION}.msi
	rm pharo-windows-certificate.p12
}

function set_env() {
	DATE=$(date +%Y.%m.%d)
	case "$ARCHITECTURE" in
	        32) ARCH_SUFFIX="x86"
	        	;;
	        64) ARCH_SUFFIX="x64"
				export ARCH=64
	        	;;
	        *) 	echo "Error! Architecture $ARCH is not supported!"
				exit 1
				;;
	esac
	if [ "$VERSION" == "bleedingEdge" ]
	then
		VERSION_NUMBER="$VERSION-$DATE-$ARCH_SUFFIX"
	else
		VERSION_NUMBER="$VERSION-$ARCH_SUFFIX"
	fi
	set_pharo_sources_version
}

function copy_current_stable_image() {
	local IMAGES_PATH="images"
	mkdir "$IMAGES_PATH"
	wget -P $IMAGES_PATH https://files.pharo.org/image/stable/latest.zip
    mv "$IMAGES_PATH/latest.zip" "$IMAGES_PATH/pharo-stable.zip"
}

function set_pharo_sources_version() {
	local sources_file=$(ls One/PharoV*.sources)
	if [ -z "$sources_file" ]
	then
		# Need to determine Sources file version
		local HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://files.pharo.org/sources/PharoV$1.sources.zip)
		if [ $HTTP_CODE -eq 404 ]
		then
	  		PHARO_SOURCES=60
		fi
	else
		# Sources file already retrieved
		PHARO_SOURCES=${sources_file:10:2}
	fi
}

function get_pharo_sources_version() {
	set_pharo_sources_version ${PHARO_SOURCES}
	wget --quiet https://files.pharo.org/sources/PharoV${PHARO_SOURCES}.sources.zip && unzip PharoV${PHARO_SOURCES}.sources.zip PharoV${PHARO_SOURCES}.sources && rm PharoV${PHARO_SOURCES}.sources.zip
}

PHARO=${PHARO:=61}  	# If PHARO not set, set it to 61.
VM=${VM:=vm}			# If VM not set, set it to vm.
ARCH=${ARCH:-'32'}		# If ARCH not set, set it to 32 bits
VERSION=${VERSION:=$2}  # If VERSION not set, set it to the first parameter of this script. Will fail if not provided

SCRIPT_TARGET=${1:-all}
echo "Running target $SCRIPT_TARGET"
echo "Using a Pharo$PHARO image and ${ARCH}-bits $VM virtual machines from get-giles. Will load version $VERSION of PharoLauncher"

case $SCRIPT_TARGET in
prepare)
  prepare_image
  ;;
test)
  run_tests
  ;;
developer)
  package_developer_version
  ;;
user)
  package_user_version
  ;;
win-package)
  package_windows_version
  ;;
mac-package)
  package_mac_version
  ;;
linux-package)
  package_linux_version
  ;;
all)
  prepare_image && run_tests && package_developer_version && package_user_version \
  	&& package_linux_version
  ;;
*)
  echo "No valid target specified! Exiting"
  ;;
esac
