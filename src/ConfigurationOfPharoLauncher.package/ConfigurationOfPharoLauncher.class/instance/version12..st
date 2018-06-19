versions
version12: spec
	<version: '1.2' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2
New features:
	#21 Bless the DMG
	#46 sign pharo launcher app for windows
	#103 No way to rename a local template
	#107 Unable to add a description for the image using the Launcher UI
	#121 You can''t see/sort images by last modified date
Improvements:
	#69 Import command should also import pharo-local directory
	#70 Import command should delete origin folder if empty
	#73 Managers of Download of VMs and images should be in their own packages
	#76 Use https instead of http to requests the pharo file server
	#82 Official Distributions loads 32bit versions on 64bit System (i.e. provide better information on templates architecture)
	#86 Sort Existing Images Case-Insensitive
	#98 Copy and subfolders problem (contents no copied)
	#101 Templates from a local image are listed in "downloaded". "local" would be a better name
	#102 Template Cleared at Startup setting is enabled, making it weird when trying to use the template feature
	#106 Import could work if we select the parent folder of an image
	#109 Use latest pre-Spur VM to determine the image version
	#122 The Run without settings icon looks like a funny grey/which blob (missing alpha correction)
Bux fixes:
	#41 #selectedMorphList was sent to nil
	#67 bash is not a command usable under windows
	#68 Does not launch images on Windows
	#85 Double click on an existing image open a file selector
	#88 Pharo Launcher on Windows > Failing
	#104 GUI bug makes Launcher unusable
	#110 Image launch not reliable on Windows
	#119 MessageNotUnderstood exception on launch
	#123 The status bar of the Launcher is broken, so can''t easily show image descriptions '.
		spec author: 'Christophe Demarey'.
		spec timestamp: '06/19/2018 13:49'.
		spec 
			project: 'XMLParser' with: '3.5.0';
			project: 'OSProcess' with: '4.6.13';
			project: 'ProcessWrapper' with: '1.2';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.197';
			package: #'PharoLauncher-Download' with: 'PharoLauncher-Download-ChristopheDemarey.13';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.71';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.25';
			package: #'PharoLauncher-Tests-Download' with: 'PharoLauncher-Tests-Download-ChristopheDemarey.4'. ].