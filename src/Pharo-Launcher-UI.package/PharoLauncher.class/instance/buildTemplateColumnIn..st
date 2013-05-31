interface building
buildTemplateColumnIn: constructor
	constructor
		title: 'Templates';
		act: [ self updateTemplates ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh';
		accordionArrangement.
	self categories
		do: [ :category | 
			constructor list
				title: category;
				display: [ templateGroupCache templatesAtCategory: category ];
				selectionAct: [ :widget | self extractTemplate: widget selection ] entitled: 'Create new...';
				format: #name ]