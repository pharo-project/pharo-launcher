initialization
initializeWidgets
	self instantiateModels: #(#label #LabelModel #refreshButton #ButtonModel).
	label text: ''.
	refreshButton
		icon: Smalltalk ui icons refreshIcon;
		action: refreshAction;
		state: false