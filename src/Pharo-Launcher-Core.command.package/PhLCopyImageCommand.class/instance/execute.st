action
execute
	| name |
	name := self newImageName.
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository copyImage: context singleImage to: name.