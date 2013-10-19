initialization
initializeWidgets
	(imagesModel := PhLTitledTreeModel new)
		title: 'Existing images' translated;
		refreshAction: [ self updateImages ];
		displayBlock: [ :image | image name ];
		doubleClick: [ self launchImage ];
		menu: [ :menu | self imagesMenu: menu ];
		makeMultiSelect.
		
	(templatesModel := PhLTitledTreeModel  new)
		title: 'Templates' translated;
		refreshAction: [ self refreshTemplateGroups ];
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | group children: self ];
		menu: [ :menu | self templatesMenu: menu ].
		
	statusbarModel := PhLStatusbar new.
	
	self updateImages.
	templatesModel roots: templateRepository groups.