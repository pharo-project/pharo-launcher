interface building
buildExistingImagesIn: constructor
	constructor list
		title: 'Existing images';
		selectionAct: [ :widget | self launch: widget selection ] entitled: 'Launch ...';
		display: [ imageGroup images ];
		format: #name
	