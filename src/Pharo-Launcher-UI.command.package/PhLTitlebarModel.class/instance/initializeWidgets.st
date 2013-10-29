initialization
initializeWidgets
	(label := self newLabel)
		text: ''.

	(refreshButton := self newButton)
		icon: Smalltalk ui icons smallUpdateIcon;
		action: refreshAction;
		state: false.
		