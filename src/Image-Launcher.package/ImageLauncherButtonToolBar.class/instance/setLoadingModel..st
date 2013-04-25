initialization
setLoadingModel: aString
	
	loadingButtonModel
		state: false;
		label: 'Loading ', aString;
		action: [ self refreshModel ].
	
