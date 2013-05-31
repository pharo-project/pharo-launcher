interface building
buildTemplateCategoriesIn: constructor
	constructor accordionArrangement.
	templateGroupCache categories sorted
		do: [ :category | 
			constructor list
				title: category;
				display: [ templateGroupCache templatesAtCategory: category ];
				selectionAct: [ :widget | self extractTemplate: widget selection ] entitled: 'Create new...';
				format: #name ]