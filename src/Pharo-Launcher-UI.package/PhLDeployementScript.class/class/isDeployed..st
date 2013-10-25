settings
isDeployed: aBoolean
	IsDeployed := aBoolean.
	aBoolean 
		ifTrue: [  self closeWindowsAndOpenDevelopmentEnvironment ]
		ifFalse: [ self closeWindowsAndOpenLauncher ]