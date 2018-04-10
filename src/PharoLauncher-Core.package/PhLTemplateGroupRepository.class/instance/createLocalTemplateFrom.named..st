action
createLocalTemplateFrom: anImage named: aString
	(self hasLocalTemplateNamed: aString)
		ifTrue: [ PhLError signal: 'A local template with the same name already exists' ].
	self createZipArchiveFrom: anImage named: aString.
	self createLocalTemplateNamed: aString.
	self refresh