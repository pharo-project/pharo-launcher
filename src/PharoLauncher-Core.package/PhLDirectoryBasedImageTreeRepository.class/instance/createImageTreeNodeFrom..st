action
createImageTreeNodeFrom: aName
	(self baseDirectory / aName) ensureCreateDirectory.
	self contentsChanged.