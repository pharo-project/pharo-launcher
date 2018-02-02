action
makeUniqueTemplateName: aString
	|  localTemplateNames |
	localTemplateNames := PhLDownloadedTemplateGroup default templatesAndGroups collect: [ :each | each name ].
	^ self makeUniqueTemplateName: aString among: localTemplateNames