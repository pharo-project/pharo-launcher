accessing
localTemplateNamed: aString
	^ PhLDownloadedTemplateGroup default templatesAndGroups 
		detect: [ :each | each name = aString ]