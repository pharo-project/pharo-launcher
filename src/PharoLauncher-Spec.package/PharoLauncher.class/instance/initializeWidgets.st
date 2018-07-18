initialization
initializeWidgets

	statusbarModel := self newStatusBar.
	
	(imagesModel := self newSearchableTitledTree)
		title: 'Current Images' translated;
		doubleClickCommandClass: PhLLaunchImageCommand;
		whenSelectionChanged: [:items | self updateStatusBarWith: items ];
		makeMultiSelect.
	(templatesModel := self newTitledTree)
		title: 'New Image Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
	
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label: 'Quit on launch';
		state: PhLLaunchImageCommand quitOnLaunch;
		whenChangedDo: [ PhLLaunchImageCommand quitOnLaunch: self quitOnLaunchCheckBoxModel state ].
	PhLLaunchImageCommand announcer weak
		when: PhLQuitOnLaunchValueChanged 
		send: #refreshQuitOnLaunchCheckBox
		to: self.
		
	self whenChangedDo: [  :w  | w whenClosedDo:  [ PhLLaunchImageCommand announcer unsubscribe: self ] ].
	self whenBuiltDo: [ 
		self 
			initializeImageAndTemplates; 
			initializeKeyboardShortcuts ].