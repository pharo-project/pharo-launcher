system startup
startUp
	self isDeployed
		ifTrue: [ self closeWindowsAndOpenLauncher ]