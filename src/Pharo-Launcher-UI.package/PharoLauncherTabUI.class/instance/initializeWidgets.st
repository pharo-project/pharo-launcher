initialization
initializeWidgets

	self instantiateModels: #(
		listModel ListComposableModel
		toolbarModel #PharoLauncherButtonToolBar ).
	self toolbarModel primaryUI: self.
	
	self focusOrder
		add: listModel;
		add: toolbarModel.