initialization
initialize
	super initialize.
	refreshAction := [  ] asValueHolder.
	refreshAction whenChangedDo: [ :newValue | refreshButton action: newValue ]