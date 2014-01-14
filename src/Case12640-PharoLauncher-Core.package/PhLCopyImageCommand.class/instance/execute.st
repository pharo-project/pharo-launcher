action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository copyImage: context singleImage to: name.