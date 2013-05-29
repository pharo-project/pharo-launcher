interface building
buildExistingImagesIn: constructor
	constructor list
		title: 'Existing images';
		selectionAct: [ :widget | self launchImage: widget selection ] entitled: 'Launch ...';
		selectionAct: [ :widget | self deleteImage: widget selection ] entitled: 'Delete';
		display: [ imageGroup images ];
		format: #name
	