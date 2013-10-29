accessing
execute
	| name |
	name := self newImageName.
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository renameImage: context singleImage to: name