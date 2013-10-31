initialization
initializeWidgets
	(imagesModel := self newTitledTree)
		title: 'Existing images' translated;
		displayBlock: [ :image | image name ];
		doubleClick: [ self launchImage ];
		makeMultiSelect.
	(templatesModel := self newTitledTree)
		title: 'Templates' translated;
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | group children: self ].
	statusbarModel := self newStatusBar.
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label: 'Quit on launch';
		state: PhLLaunchImageCommand quitOnLaunch;
		whenChangedDo: [ PhLLaunchImageCommand quitOnLaunch: self quitOnLaunchCheckBoxModel state ].