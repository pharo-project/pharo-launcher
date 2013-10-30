menu
imagesMenu: menu
	(menu add: 'Launch image' target: self selector: #launchImage) enablementSelector: #has1AndJust1ImageSelected.
	(menu addLine).
	(menu add: 'Rename' target: self selector: #renameImage) enablementSelector: #has1AndJust1ImageSelected.
	(menu add: 'Copy' target: self selector: #copyImage) enablementSelector: #has1AndJust1ImageSelected.
	(menu add: 'Delete' target: self selector: #deleteImages).
	(menu add: 'Show in folder' target: self selector: #showNativeFolder) enablementSelector: #has1AndJust1ImageSelected.
	