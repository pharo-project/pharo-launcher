action
ensureNoImageWithName: anImageName
	(self imageNames includes: anImageName)
		ifTrue: [ PhLError signal: 'An image with the same name already exists' ]