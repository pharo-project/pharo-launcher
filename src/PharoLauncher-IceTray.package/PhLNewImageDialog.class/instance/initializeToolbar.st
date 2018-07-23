accessing
initializeToolbar
	self toolbar
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallNewIcon);
				help: 'Create new image';
				action: [ self createNewImage ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallLoadProject);
				help: 'Import image';
				action: [ self spawnImportImageDialog ];
				yourself)
			position: ITItemPosition left