interface building
buildTemplateColumnIn: constructor
	constructor
		title: 'Templates';
		act: [ self updateTemplates ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh'.
	constructor tree
		children: [ :group | 
					self flag: 'TODO: implement recursive groups and remove this #isKindOf:'.
					(group isKindOf: PhLAbstractTemplateGroup)
						ifTrue: [ group templates ]
						ifFalse: [ #() ] ];
		selectionAct: [ :widget | self extractTemplate: widget selection ] entitled: 'Create new...';
		format: #name