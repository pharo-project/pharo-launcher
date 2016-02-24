action
createLocalTemplateFrom: anImage named: aString
	| localTemplate |
	(self hasLocalTemplateNamed: aString)
		ifTrue: [ PhLError signal: 'A local template with the same name already exists' ].
	self createZipArchiveFrom: anImage named: aString.
	localTemplate := PhLLocalTemplate name: aString zipFile: PhLLocalTemplateGroup default baseDirectory / aString , 'zip'.
	PhLLocalTemplateGroup default register: localTemplate withZip: localTemplate zipArchive.
	self refresh