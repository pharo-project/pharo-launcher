settings
developmentEnvironmentEnabled: aBoolean
	aBoolean 
		ifTrue: 
		[	self new undoAll.  	
			self closeWindowsAndOpenDevelopmentEnvironment 
		]
		ifFalse: 
		[ 	self new doAll. 
			self closeWindowsAndOpenLauncher 
		].