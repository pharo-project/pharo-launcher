action
deleteImageNamed: aString
	(self directoryForImageNamed: aString) deleteAll.
	self contentsChanged.