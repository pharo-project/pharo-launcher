action
makeUniqueTemplateName: aString
	|  localTemplateNames |
	localTemplateNames := PhLLocalTemplateGroup default templatesAndGroups collect: [ :each | each name ].
	^ self makeUniqueTemplateName: aString among: localTemplateNames