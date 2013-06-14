action
copyImageNamed: sourceName to: targetName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	sourceDirectory := self directoryForImageNamed: sourceName.
	sourceDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := (#('image' 'changes') includes: file extension)
				ifTrue: [ targetName , '.', file extension ]
				ifFalse: [ file basename ].
			file copyTo: targetDirectory / targetFilename ]