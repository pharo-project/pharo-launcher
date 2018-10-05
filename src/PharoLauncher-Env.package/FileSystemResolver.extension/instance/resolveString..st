*PharoLauncher-Env
resolveString: aString
	| fs |
	fs := FileSystem disk.
	^ FileReference 
		fileSystem: fs 
		path: (fs pathFromString: aString)