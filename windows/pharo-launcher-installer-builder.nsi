!define APPNAME "PharoLauncher"
!define DESCRIPTION "Manage your Pharo images easily"
!define VERSIONMAJOR 1
!define VERSIONMINOR 1
!define VERSIONBUILD 1

# These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
# It is possible to use "mailto:" links in here to open the email client
!define HELPURL "mailto://pharo-users@lists.pharo.org" # "Support Information" link
!define UPDATEURL "https://github.com/pharo-project/pharo-launcher/releases" # "Product Updates" link
!define ABOUTURL "https://github.com/pharo-project/pharo-launcher" # "Publisher" link

# This is the size (in kB) of all the files copied into "Program Files"
!define INSTALLSIZE 69664

InstallDir "${LOCALAPPDATA}\${APPNAME}"

# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
# LicenseData "license.rtf"

Name "${APPNAME}"
Icon "pharo-launcher.ico"
outfile "pharo-launcher-installer.exe"

!include LogicLib.nsh
 
# Just three pages - license agreement, install location, and installation
# page license
page directory
Page instfiles

function .onInit
	setShellVarContext all
functionEnd

section "install"
	# Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
	# Files added here should be removed by the uninstaller (see section "uninstall")
	setOutPath $INSTDIR
	file pharo-launcher.ico
	# you can use the following command to generate the list of files needed by the Pharo VM:
	# find Pharo -depth 1 -type f -not -iname "*.zip" -exec bash -c 'file=$(basename {}); echo "file Pharo-win\Pharo\\$file"' \;

	file Pharo-win\Pharo\FT2Plugin.dll
	file Pharo-win\Pharo\iconv.dll
	file Pharo-win\Pharo\libcairo-2.dll
	file Pharo-win\Pharo\libeay32.dll
	file Pharo-win\Pharo\libfreetype.dll
	file Pharo-win\Pharo\libgcc_s_sjlj-1.dll
	file Pharo-win\Pharo\libgit2.dll
	file Pharo-win\Pharo\libpixman-1-0.dll
	file Pharo-win\Pharo\libpng16-16.dll
	file Pharo-win\Pharo\libssh2-1.dll
	file Pharo-win\Pharo\libwinpthread-1.dll
	file Pharo-win\Pharo\Pharo.changes
	file Pharo-win\Pharo\Pharo.exe
	file Pharo-win\Pharo\Pharo.image
	file Pharo-win\Pharo\Pharo.ini
	file Pharo-win\Pharo\PharoConsole.exe
	file Pharo-win\Pharo\PharoV60.sources
	file Pharo-win\Pharo\ProcessWrapperPlugin.dll
	file Pharo-win\Pharo\README.txt
	file Pharo-win\Pharo\SDL2.dll
	file Pharo-win\Pharo\SqueakSSL.dll
	file Pharo-win\Pharo\ssleay32.dll
	file Pharo-win\Pharo\SurfacePlugin.dll
	file Pharo-win\Pharo\zlib1.dll

	# find Pharo -type d -depth 1 -exec bash -c 'file=$(basename {}); echo "file /r Pharo-win\Pharo\\$file"' \;
	file /r Pharo-win\Pharo\images

	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\uninstall.exe"
 
	# Start Menu
	createDirectory "$SMPROGRAMS\${APPNAME}"
	createShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\pharo.exe" "" "$INSTDIR\pharo-launcher.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME} - ${DESCRIPTION}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayIcon" "$\"$INSTDIR\pharo.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "Publisher" "$\"${APPNAME}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "VersionMinor" ${VERSIONMINOR}
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoRepair" 1
	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "EstimatedSize" ${INSTALLSIZE}
sectionEnd

# Uninstaller
 
function un.onInit
	SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanently remove ${APPNAME}?" IDCANCEL
		Abort
functionEnd
 
section "uninstall"
 
	# Remove Start Menu launcher
	delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
	# Try to remove the Start Menu folder - this will only happen if it is empty
	rmDir "$SMPROGRAMS\${APPNAME}"

	# Delete Files 
  	rmDir /r "$INSTDIR\*.*"    
 
	#Remove the installation directory
  	rmDir "$INSTDIR"
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
sectionEnd
