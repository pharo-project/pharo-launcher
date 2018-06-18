action
importImageNamed: sourceName to: targetName
	| targetDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	{ sourceName asFileReference . sourceName asFileReference withoutExtension , 'changes' }
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: targetName.
			file moveTo: targetDirectory / targetFilename ].
	self contentsChanged.