testing
hasLocalTemplateNamed: aString
	^PhLDownloadedTemplateGroup default templatesAndGroups anySatisfy: [ :each | each name = aString ]