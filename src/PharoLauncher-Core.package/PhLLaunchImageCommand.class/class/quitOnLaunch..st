settings
quitOnLaunch: aBoolean
	| oldValue |
	oldValue := QuitOnLaunch.
	QuitOnLaunch := aBoolean.
	oldValue = QuitOnLaunch 
		ifFalse: [ CommandAnnouncer announce: PhLQuitOnLaunchValueChanged ]