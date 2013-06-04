action
extractTemplate: aTemplate to: anImageName
	| destination |
	self ensureNoImageWithName: anImageName.
	destination := self prepareForNewImageNamed: anImageName.
	aTemplate extractTo: destination named: anImageName