accessing
vmStore
	^ (PlatformResolver forCurrentPlatform launcherUserFilesLocation / 'vms') ensureCreateDirectory