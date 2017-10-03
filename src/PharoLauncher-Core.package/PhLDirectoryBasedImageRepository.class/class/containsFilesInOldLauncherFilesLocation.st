migration
containsFilesInOldLauncherFilesLocation
	| oldLocation |
	oldLocation := PlatformResolver forCurrentPlatform launcherOldLocationForImages.
	^ oldLocation exists and: [ oldLocation hasChildren ]