initialize-release
initializeImageFrom: aDirectory 
	| imageName imageFiles changeFiles |
	imageName := aDirectory basename.
	imageFiles := aDirectory filesMatching: imageName, '.image'.
	changeFiles := aDirectory filesMatching: imageName, '.changes'.
	(imageFiles size ~= 1 or: [ changeFiles size ~= 1 ])
		ifTrue: [ ^ nil ].
	^ PhLImage new
		setName: imageName location: imageFiles first