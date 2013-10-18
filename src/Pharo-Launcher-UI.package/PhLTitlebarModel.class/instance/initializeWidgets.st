initialization
initializeWidgets
	(label := LabelModel new) 
		text: ''.

	(refreshButton := ButtonModel new)
		icon: Smalltalk ui icons refreshIcon;
		action: refreshAction;
		state: false.