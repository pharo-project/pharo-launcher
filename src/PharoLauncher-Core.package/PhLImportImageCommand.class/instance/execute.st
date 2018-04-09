action
execute
	| answer |
	answer := UIManager default
		chooseFrom:
			{'Launch the image' . 'Import the image into Pharo Launcher images store (will move files to the new destination)'}
		lines: #()
		title: 'What would you like to do?'.
	answer = 1
		ifTrue: [ (PhLLaunchImageCommand on: context) launchImageFromDisk ].
	answer = 2
		ifTrue:	[ self importImage ]