initialization
initializeToolbar.

	self toolbar
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallNewIcon);
				help: 'Create new image';
				action: [ self spawnNewImageDialog ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallDoItIcon);
				help: 'Launch image with settings';
				action: [ self launchSelectedImageWithSettings ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallDoItIcon) asGrayScaleWithAlpha;
				help: 'Launch image without settings';
				action: [ self launchSelectedImageWithoutSettings ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallLoadProject);
				help: 'Import image';
				action: [ self spawnImportImageDialog ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallDelete);
				help: 'Delete selected image';
				action: [ self deleteSelectedImage ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallUpdateIcon);
				help: 'Refresh image table';
				action: [ self refresh ];
				yourself)
			position: ITItemPosition left.