action
ensureNoImageWithName: anImageName
	(self imageNames includes: anImageName)
		ifTrue: [ Error signal: 'An image with the same name already exists' ]