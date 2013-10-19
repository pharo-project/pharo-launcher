initialization
initializeWidgets
	(label := self newLabel)
		text: ''.

	(refreshButton := self newButton)
		icon: Smalltalk ui icons refreshIcon;
		action: refreshAction;
		state: false.