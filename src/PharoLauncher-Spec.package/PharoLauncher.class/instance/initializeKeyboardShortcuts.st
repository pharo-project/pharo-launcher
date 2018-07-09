initialization
initializeKeyboardShortcuts
	self widget
		bindKeyCombination: $f meta asKeyCombination
		toAction: [ self actionSearch ]