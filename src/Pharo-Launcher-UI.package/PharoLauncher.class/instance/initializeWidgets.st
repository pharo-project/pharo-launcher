initialization
initializeWidgets
	self
		instantiateModels:
			#(#imagesModel #PhLTitledTreeModel #templatesModel #PhLTitledTreeModel #statusbarModel #PhLStatusbar).
	imagesModel
		title: 'Existing images' translated;
		refreshAction: [ self updateImages ];
		displayBlock: [ :image | image name ];
		doubleClick: [ self launchImage ];
		menu: [ :menu | self imagesMenu: menu ].
	templatesModel
		title: 'Templates' translated;
		refreshAction: [ self updateTemplates ];
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | group children: self ];
		menu: [ :menu | self templatesMenu: menu ].
	self updateAll