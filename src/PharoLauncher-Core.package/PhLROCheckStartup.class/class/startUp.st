system startup
startUp
	[ (FileLocator workingDirectory / 'phl-canwrite') asFileReference  
			ensureDelete; 
			createDirectory;
			ensureDelete. ]
	on: Error
	do: [ :error |  
		UIManager default 
			alert: 'PharoLauncher cannot be run from a read-only filesystem. Please move it to a place where you have write permissions!' 
			title: 'Cannot run PharoLauncher!'.
		Smalltalk quitPrimitive ].