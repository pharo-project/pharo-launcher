initialization
initializeWidgets
	(imagesModel := self newTitledTree)
		title: 'Existing images' translated;
		refreshAction: [ self updateImages ];
		displayBlock: [ :image | image name ];
		doubleClick: [ self launchImage ];
		menu: [ :menu | self imagesMenu: menu ];
		makeMultiSelect.
		
	(templatesModel := self newTitledTree)
		title: 'Templates' translated;
		refreshAction: [ self refreshTemplateGroups ];
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | group children: self ];
		menu: [ :menu | self templatesMenu: menu ].
		
	statusbarModel := self newStatusBar. 
	
	(quitOnLaunchCheckBoxModel := self newCheckBox)
		label:'Quit on launch'.
	
	self updateImages.
	templatesModel roots: templateRepository groups.