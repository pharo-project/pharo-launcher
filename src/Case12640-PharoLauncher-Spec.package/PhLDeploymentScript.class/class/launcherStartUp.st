system startup
launcherStartUp
	self isDeployed
		ifTrue: [ self closeWindowsAndOpenLauncher ]