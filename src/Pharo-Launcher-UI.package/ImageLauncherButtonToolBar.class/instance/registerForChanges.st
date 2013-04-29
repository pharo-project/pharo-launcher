initialization
registerForChanges

	self model whenChangedDo: [:contents || boolean |
		boolean := contents
						ifNil: [ false ]
						ifNotNil: [ true ].
		refreshModel state: boolean.
		loadingModel state: boolean.]