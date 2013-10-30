initialization
initializeWidgets
	labelModel := self newLabel. 
	
	(settingsButton := self newButton)
		icon: Smalltalk ui icons configurationIcon;
		action: [ self openSettings ];
		state: false.
