action
copyImage: anImage to: aString
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: aString.
	targetDirectory := self prepareForNewImageNamed: aString.
	sourceDirectory := self directoryForImage: anImage.
	sourceDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := (#('image' 'changes') includes: file extension)
				ifTrue: [ aString , '.', file extension ]
				ifFalse: [ file basename ].
			file copyTo: targetDirectory / targetFilename ]