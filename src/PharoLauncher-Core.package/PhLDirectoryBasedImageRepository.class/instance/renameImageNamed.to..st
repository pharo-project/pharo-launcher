action
renameImageNamed: oldName to: newName
	| sourceDirectory |
	sourceDirectory := self directoryForImageNamed: oldName.
	self moveImage: sourceDirectory to: newName 