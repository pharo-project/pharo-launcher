action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository renameImage: context singleImage to: name