initialization
initializePresenter

	listModel whenSelectedItemChanged: [:selection |
		selection
			ifNil: [
				toolbarModel setLoadingModel ]
			ifNotNil: [ 
				toolbarModel setLoadingModel: selection ]].
	