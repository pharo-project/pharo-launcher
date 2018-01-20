action
importImageNamed: sourceName to: targetName
	| sourceDirectory targetDirectory imageLocalDirectory |
	self ensureNoImageWithName: targetName.
	sourceDirectory := sourceName asFileReference parent.
	targetDirectory := self prepareForNewImageNamed: targetName.
	{ sourceName asFileReference . sourceName asFileReference withoutExtension , 'changes' }
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: targetName.
			file moveTo: targetDirectory / targetFilename ].
	imageLocalDirectory := (sourceDirectory / SystemResolver defaultLocalDirectoryName).
	imageLocalDirectory exists 
		ifTrue: [ imageLocalDirectory moveTo: targetDirectory / imageLocalDirectory basename ].
	sourceDirectory hasChildren 
		ifFalse: [ sourceDirectory delete ].
	self contentsChanged.