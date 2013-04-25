initialization
initializeWidgets

	self instantiateModels: #(
		listModel ListComposableModel
		toolbarModel ImageLauncherButtonToolBar ).
	self toolbarModel primaryUI: self.
	
	self focusOrder
		add: listModel;
		add: toolbarModel.