initialization
initializeWidgets
	labelModel := self newLabel. 
	
	(settingsButton := self newButton)
		icon: Smalltalk ui icons alertIcon;
		action: [ self openSettings ];
		state: false.
