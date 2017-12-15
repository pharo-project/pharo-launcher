#!/usr/bin/env bash

set -ex

# Pharo Launcher build script
#
# We expect to have $PHARO and $VM parameter available in the environment
# $PHARO : version of the Pharo image, e.g. 61
# $VM : version of the VM, e.g. vm
# $VERSION: the Metacello version of PharoLauncher to load

# Script parameters
# $1: the target to run between prepare | test | developer | user
# $2: a value for $VERSION (optional)

function prepare_image() {
	wget --quiet -O - get.pharo.org/$PHARO+$VM | bash

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
	VERSION_NUMBER=$(cat launcher-version.txt)

	zip -9r PharoLauncher-developer.zip PharoLauncher.image PharoLauncher.changes launcher-version.txt
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
	get_pharo_sources_version $PHARO_SOURCES
	copy_current_stable_image
	cd ..

	DATE=$(date +%Y.%m.%d)
	bash ./pharo-build-scripts/build-platform.sh -i Pharo -o Pharo -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t Pharo -p mac
	bash ./pharo-build-scripts/build-platform.sh -i Pharo -o Pharo -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t Pharo -p win
	bash ./pharo-build-scripts/build-platform.sh -i Pharo -o Pharo -r $PHARO -s $PHARO_SOURCES -v $VERSION-$DATE -t Pharo -p linux
	mv Pharo-linux.zip Pharo-linux-$VERSION_NUMBER.zip

	zip -9r PharoLauncher-user-$VERSION-$DATE.zip PharoLauncher.image PharoLauncher.changes launcher-version.txt

	md5sum PharoLauncher-user-$VERSION-$DATE.zip > PharoLauncher-user-$VERSION-$DATE.zip.md5sum
}

function copy_current_stable_image() {
	local IMAGES_PATH="images"
	mkdir "$IMAGES_PATH"
	wget -P $IMAGES_PATH https://files.pharo.org/image/stable/latest.zip
    mv "$IMAGES_PATH/latest.zip" "$IMAGES_PATH/pharo-stable.zip"
}

function get_pharo_sources_version() {
	local HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://files.pharo.org/sources/PharoV$1.sources.zip)
	if [ $HTTP_CODE -eq 404 ]
	then
  		PHARO_SOURCES=60
	fi
	wget --quiet https://files.pharo.org/sources/PharoV${PHARO_SOURCES}.sources.zip && unzip PharoV${PHARO_SOURCES}.sources.zip PharoV${PHARO_SOURCES}.sources && rm PharoV${PHARO_SOURCES}.sources.zip
}

PHARO=${PHARO:=61}  	# If PHARO not set, set it to 61.
VM=${VM:=vm}			# If VM not set, set it to vm.
VERSION=${VERSION:=$2}  # If VERSION not set, set it to the first parameter of this script. Will fail if not provided

SCRIPT_TARGET=${1:-all}
echo "Running target $SCRIPT_TARGET"
echo "Using a Pharo$PHARO image and $VM virtual machines from get-giles. Will load version $VERSION of PharoLauncher"

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
all)
  prepare_image && run_tests && package_developer_version && package_user_version
  ;;
*)
  echo "No valid target specified! Exiting"
  ;;
esac
