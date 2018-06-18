initialization
initializeWidgets

	statusbarModel := self newStatusBar.
	
	(imagesModel := self newSearchableTitledTree)
		title: 'Existing images' translated;
		doubleClickCommandClass: PhLLaunchImageCommand;
		whenSelectionChanged: [:items | self updateStatusBarWith: items ];
		makeMultiSelect.
	(templatesModel := self newTitledTree)
		title: 'Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
	
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label: 'Quit on launch';
		state: PhLLaunchImageCommand quitOnLaunch;
		whenChangedDo: [ PhLLaunchImageCommand quitOnLaunch: self quitOnLaunchCheckBoxModel state ].
	PhLLaunchImageCommand announcer weak
		when: PhLQuitOnLaunchValueChanged 
		send: #refreshQuitOnLaunchCheckBox
		to: self.
	self whenWindowClosed: [ PhLLaunchImageCommand announcer unsubscribe: self ].
	self whenBuiltDo: [ self initializeImageAndTemplates ]