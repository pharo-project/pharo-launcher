initialization
initializeWidgets
	self
		instantiateModels:
			#(#imagesModel #PhLTitledTreeModel #templatesModel #PhLTitledTreeModel #statusbarModel #PhLStatusbar).
	imagesModel
		title: 'Existing images';
		refreshAction: [ self updateImages ];
		displayBlock: [ :image | image name ];
		menu: [ :menu | self imagesMenu: menu ].
	templatesModel
		title: 'Templates';
		refreshAction: [ self updateTemplates ];
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | group children: self ];
		menu: [ :menu | self templatesMenu: menu ].
	self updateAll