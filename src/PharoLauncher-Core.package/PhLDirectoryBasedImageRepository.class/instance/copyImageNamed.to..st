action
copyImageNamed: sourceName to: targetName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: targetName.
	targetDirectory := self prepareForNewImageNamed: targetName.
	sourceDirectory := self directoryForImageNamed: sourceName.
	CopyVisitor copy: sourceDirectory to: targetDirectory.
	self renameImageInFolder: targetDirectory to: targetName.
	self contentsChanged