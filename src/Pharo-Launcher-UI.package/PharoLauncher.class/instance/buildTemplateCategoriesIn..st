interface building
buildTemplateCategoriesIn: constructor
	constructor accordionArrangement.
	group categories sorted
		do: [ :category | 
			constructor list
				title: category;
				display: [ group templatesAtCategory: category ];
				format: #name ]