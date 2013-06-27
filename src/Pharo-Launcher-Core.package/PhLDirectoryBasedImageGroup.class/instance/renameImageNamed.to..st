action
renameImageNamed: oldName to: newName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: newName.
	targetDirectory := self prepareForNewImageNamed: newName.
	sourceDirectory := self directoryForImageNamed: oldName.
	sourceDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: newName.
			file moveTo: targetDirectory / targetFilename ].
	sourceDirectory delete