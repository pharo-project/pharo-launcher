action
renameImageNamed: oldName to: newName
	| sourceDirectory targetDirectory |
	self ensureNoImageWithName: newName.
	targetDirectory := self directoryForImageNamed: newName.	"Do not create a new directory to ensure that the moveTo will succeed"
	sourceDirectory := self directoryForImageNamed: oldName.
	sourceDirectory moveTo: targetDirectory.
	self renameImageInFolder: targetDirectory to: newName.
	self contentsChanged