action
renameImageNamed: oldName to: newName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: newName.
	targetDirectory := self prepareForNewImageNamed: newName.
	sourceDirectory := self directoryForImageNamed: oldName.
	sourceDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := (#('image' 'changes') includes: file extension)
				ifTrue: [ newName , '.', file extension ]
				ifFalse: [ file basename ].
			file moveTo: targetDirectory / targetFilename ].
	sourceDirectory delete