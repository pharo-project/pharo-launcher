initialization
initializeWidgets
	(label := self newLabel)
		text: ''.

	(refreshButton := self newButton)
		icon: Smalltalk ui icons refreshIcon;
		action: refreshAction;
		state: false.
		
	(settingsButton := self newButton)
		icon: Smalltalk ui icons alertIcon;
		action: [ self openSettings ];
		state: false.