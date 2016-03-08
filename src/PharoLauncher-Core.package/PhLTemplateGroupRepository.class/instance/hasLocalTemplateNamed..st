testing
hasLocalTemplateNamed: aString
	^PhLLocalTemplateGroup default templatesAndGroups anySatisfy: [ :each | each name = aString ]