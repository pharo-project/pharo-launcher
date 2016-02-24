action
makeUniqueTemplateName: aString
	| localTemplateGroup localTemplateNames |
	localTemplateGroup := self roots detect: [ :each | each name = 'Local' ].
	localTemplateNames := localTemplateGroup templatesAndGroups collect: [ :each | each name ].
	^ self makeUniqueTemplateName: aString among: localTemplateNames