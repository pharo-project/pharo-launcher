action
execute
	| answer |
	importSiblings := false.
	answer := UIManager default
		chooseFrom:
			{ 'Launch an image from the file system' . 
			'Import an image into Pharo Launcher images store (will move files)' .
			'Import an image and all files in its directory into Pharo Launcher images store (will move files)' }
		lines: #()
		title: 'What would you like to do?'.
	answer = 3
		ifTrue:	[ importSiblings := true ].
	(answer = 2 or: [ answer = 3 ])
		ifTrue:	[ self importImage ].
	answer = 1 
		ifTrue: [ (PhLLaunchImageCommand on: context) launchImageFromDisk ].