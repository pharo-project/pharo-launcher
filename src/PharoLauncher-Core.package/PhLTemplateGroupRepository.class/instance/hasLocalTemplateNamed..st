testing
hasLocalTemplateNamed: aString
	| localTemplateGroup |
	localTemplateGroup := self roots detect: [ :each | each name = 'Local' ].
	^ localTemplateGroup templatesAndGroups anySatisfy: [ :each | each name = aString ]