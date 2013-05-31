interface building
buildImagesColumnIn: constructor
	constructor list
		title: 'Existing images';
		selectionAct: [ :widget | self launchImage: widget selection ] entitled: 'Launch...';
		selectionAct: [ :widget | self deleteImage: widget selection ] entitled: 'Delete';
		act: [ self updateImages ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh';
		display: [ imageGroup images ];
		format: #name
	