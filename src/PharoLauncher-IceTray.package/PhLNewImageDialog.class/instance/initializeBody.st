initializing
initializeBody

	(catalogTable := self newTitledTree)
		title: 'New Image Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
		
		
		
	catalogTable

		context: self context;
		repository: PhLTemplateGroupRepository forSelectedGroups.
	propertyPanel := self instantiate: PhLImagePresenter on: nil