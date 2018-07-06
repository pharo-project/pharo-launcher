action
moveImage: sourceDirectory to: newName
	| targetDirectory |
	self ensureNoImageWithName: newName.
	targetDirectory := self directoryForImageNamed: newName.	"Do not create a new directory to ensure that the moveTo will succeed"
	sourceDirectory moveTo: targetDirectory.
	self renameImageInFolder: targetDirectory to: newName.
	self contentsChanged