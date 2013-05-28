interface building
buildTemplateCategoriesIn: constructor
	constructor accordionArrangement.
	templateGroup categories sorted
		do: [ :category | 
			constructor list
				title: category;
				display: [ templateGroup templatesAtCategory: category ];
				selectionAct: [ :widget | self extractTemplate: widget selection ] entitled: 'Create new...';
				format: #name ]