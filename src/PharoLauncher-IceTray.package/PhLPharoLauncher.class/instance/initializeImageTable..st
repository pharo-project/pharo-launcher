initialization
initializeImageTable: aTableMorph
	aTableMorph
		add: #name
			menu: [ :menu :target | 
			menu
				add: #Launch target: self selector: #launchSelectedImageWithSettings;
				add: #'Launch without settings' target: self selector: #launchSelectedImageWithSettings;
				add: #'Copy selected image' target: self selector: #copySelectedImage ]
			width: 300;
		add: #vm width: 50;
		add: #template width: 300;
		add: #'last modification' accessing: #lastModification width: 100;
		onAnnouncement: FTSelectionChanged do: [ :ann | self selectionChanged: ann];
		onAnnouncement: FTStrongSelectionChanged do: [ :ann | self launchSelectedImageWithSettings ].
	aTableMorph showRowIndex width: 50