action
copyImageNamed: sourceName to: targetName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	sourceDirectory := self directoryForImageNamed: sourceName.
	sourceDirectory children
		do: [ :file | 
			| targetFilename |
			targetFilename := self newNameForFile: file whenRelocatingToImageNamed: targetName.
			file copyTo: targetDirectory / targetFilename ].
	self contentsChanged.