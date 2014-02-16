settings
developmentEnvironmentEnabled: aBoolean
	aBoolean 
		ifTrue: 
		[	self undoAll.  	
			self closeWindowsAndOpenDevelopmentEnvironment 
		]
		ifFalse: 
		[ 	self doAll. 
			self closeWindowsAndOpenLauncher 
		].