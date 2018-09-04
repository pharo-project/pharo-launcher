initialization
initializeToolbar
	self toolbar
		addItem:
			(ITButton new
				label: 'update';
				icon: (self iconNamed: #smallUpdate);
				help: 'Update the virtual machine to the latest available version';
				action: [ self updateVms ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'show';
				icon: (self iconNamed: #smallOpen);
				help: 'Show the selected vm in its folder. Will open a system browser.';
				action: [ self showInFolder ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'remove';
				icon: (self iconNamed: #smallDeleteIcon);
				help: 'Remove virtual machine';
				action: [ self removeVms ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITToggleButton new
				label: 'private';
				icon: (self iconNamed: #smallLock);
				help: 'Show private VMs used to determine pharo version of an image!';
				beUnselected;
				action: [ :activated | self showPrivateVms: activated ];
				yourself)
			position: ITItemPosition right