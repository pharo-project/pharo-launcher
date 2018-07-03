initialization
initializeStatusbar.
		self statusbar
		addItem:
			(ITToggleButton new
				label: 'Quit on launch';
				help: 'Quit on launch ';
				action: [ :activated | self inform: activated asString ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #help);
				help: 'About';
				action: [ self refresh ];
				yourself)
			position: ITItemPosition right;
		addItem:
			(ITButton new
				icon: (self iconNamed: #configurationIcon);
				help: 'Settings';
				action: [ self refresh ];
				yourself)
			position: ITItemPosition right;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallQuitIcon);
				help: 'Quit';
				action: [ self refresh ];
				yourself)
			position: ITItemPosition right