initialization
initializeWidgets
	(label := LabelModel) 
		text: ''.

	(refreshButton := ButtonModel)
		icon: Smalltalk ui icons refreshIcon;
		action: refreshAction;
		state: false.