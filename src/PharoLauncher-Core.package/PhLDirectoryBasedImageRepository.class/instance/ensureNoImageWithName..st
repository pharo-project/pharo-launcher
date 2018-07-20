action
ensureNoImageWithName: anImageName
	(self hasImageNamed: anImageName)
		ifTrue: [ PhLError signal: 'An image with the same name already exists' ]