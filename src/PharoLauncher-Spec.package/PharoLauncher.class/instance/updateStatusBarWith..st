initialization
updateStatusBarWith: selectedItems

	statusbarModel
		content:
			(selectedItems size = 1
				ifTrue: [ selectedItems first content description ]
				ifFalse: [ '' ])