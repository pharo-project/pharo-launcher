interface building
buildTemplateColumnIn: constructor
	constructor
		title: 'Templates';
		act: [ self updateTemplates ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh';
		accordionArrangement.
	templateRepository groups
		do: [ :group | 
			constructor list
				title: group name;
				display: [ group templates ];
				selectionAct: [ :widget | self extractTemplate: widget selection ] entitled: 'Create new...';
				format: #name ]