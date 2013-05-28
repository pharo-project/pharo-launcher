action
extractTemplate: aTemplate to: anImageName
	| destination |
	(self imageNames includes: anImageName)
		ifTrue: [ Error signal: 'An image with the same name already exists' ].
	destination := self prepareForNewImageNamed: anImageName.
	aTemplate extractTo: destination named: anImageName
	