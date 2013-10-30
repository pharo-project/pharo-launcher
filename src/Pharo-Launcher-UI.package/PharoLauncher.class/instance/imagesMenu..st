menu
imagesMenu: menu
	menu addTitle: '  Pharo Launcher   ' icon: (Smalltalk ui icons pharoIcon).
	(menu add: 'Launch image' target: self selector: #launchImage) 
		icon: Smalltalk ui icons processBrowserIcon;
		enablementSelector: #has1AndJust1ImageSelected.
	(menu addLine).
	(menu add: 'Rename' target: self selector: #renameImage) enablementSelector: #has1AndJust1ImageSelected.
	(menu add: 'Copy' target: self selector: #copyImage) enablementSelector: #has1AndJust1ImageSelected.
	(menu add: 'Delete' target: self selector: #deleteImages).
	(menu addLine).
	(menu add: 'Show in folder' target: self selector: #showNativeFolder) 
		icon: Smalltalk ui icons openIcon;
		enablementSelector: #has1AndJust1ImageSelected.
	