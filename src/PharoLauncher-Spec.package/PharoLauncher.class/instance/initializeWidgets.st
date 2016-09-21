initialization
initializeWidgets
	(imagesModel := self newSearchableTitledTree)
		title: 'Existing images' translated;
		doubleClickCommandClass: PhLLaunchImageCommand;
		makeMultiSelect.
	(templatesModel := self newTitledTree)
		title: 'Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
	statusbarModel := self newStatusBar.
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label: 'Quit on launch';
		state: PhLLaunchImageCommand quitOnLaunch;
		whenChangedDo: [ PhLLaunchImageCommand quitOnLaunch: self quitOnLaunchCheckBoxModel state ].
	self whenBuiltDo: [ self initializeImageAndTemplates ]