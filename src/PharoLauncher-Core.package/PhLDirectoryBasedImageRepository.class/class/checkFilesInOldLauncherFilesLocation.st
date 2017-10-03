migration
checkFilesInOldLauncherFilesLocation
	self containsFilesInOldLauncherFilesLocation
		ifTrue: [ UIManager default alert: 
			'Content detected in old Pharo Launcher files location: ', 
				PlatformResolver forCurrentPlatform launcherOldLocationForImages fullName, String cr,
			'Pharo launcher default files location moved to ', 
				PlatformResolver forCurrentPlatform launcherUserFilesLocation fullName, '/images !' , String cr,
			'Please move these files to the new location and re-open PharoLauncher.' ]