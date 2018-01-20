action
importImageNamed: sourceName to: targetName
	| targetDirectory imageLocalDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	{ sourceName asFileReference . sourceName asFileReference withoutExtension , 'changes' }
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: targetName.
			file moveTo: targetDirectory / targetFilename ].
	imageLocalDirectory := (sourceName asFileReference parent / SystemResolver defaultLocalDirectoryName).
	imageLocalDirectory exists ifTrue: [ imageLocalDirectory moveTo: targetDirectory / imageLocalDirectory basename ].
	self contentsChanged.