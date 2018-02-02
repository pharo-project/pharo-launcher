initialization
initializeWidgets
	
	self instantiateModels: #(
		refreshButtonModel  			ButtonModel
		loadingButtonModel  			ButtonModel).
				
	self 
		setRefreshModel;
		setLoadingModel.