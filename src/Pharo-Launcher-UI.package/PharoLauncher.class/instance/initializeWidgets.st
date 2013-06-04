initialization
initializeWidgets
	self instantiateModels: #(#images #PhLTitledTreeModel #templates #PhLTitledTreeModel).
	images
		title: 'Existing images';
		refreshAction: [ self updateImages ];
		displayBlock: [ :image | image name ];
		menu: [ :menu | self imagesMenu: menu ].
	templates
		title: 'Templates';
		refreshAction: [ self updateTemplates ];
		displayBlock: [ :group | group name ];
		childrenBlock: [ :group | 
					group isGroup
						ifTrue: [ group simplifiedTemplatesAndGroups ]
						ifFalse: [ #() ] ];
		menu: [ :menu | self templatesMenu: menu ].
	self updateAll