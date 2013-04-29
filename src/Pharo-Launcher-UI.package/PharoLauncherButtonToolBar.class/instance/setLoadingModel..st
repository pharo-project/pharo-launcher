initialization
setLoadingModel: aString

	loadingButtonModel
		state: false;
		enable;
		label: 'Load ', aString;
		action: [ self loadingModel: aString ].
	
