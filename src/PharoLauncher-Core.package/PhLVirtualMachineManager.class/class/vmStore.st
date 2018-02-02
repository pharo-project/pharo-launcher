accessing
vmStore
	^ VMStore ifNil: [ VMStore := (PlatformResolver forCurrentPlatform launcherUserFilesLocation / 'vms') ensureCreateDirectory ]