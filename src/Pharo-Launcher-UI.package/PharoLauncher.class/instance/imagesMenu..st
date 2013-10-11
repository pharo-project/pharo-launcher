menu
imagesMenu: menu
	menu add: 'Launch image' target: self selector: #launchImage.
	menu addLine.
	menu add: 'Rename' target: self selector: #renameImage.
	menu add: 'Copy' target: self selector: #copyImage.
	menu add: 'Delete' target: self selector: #deleteImage