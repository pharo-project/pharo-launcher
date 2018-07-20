action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (self model isNewImageNameValid: name).
	self model imageRepository copyImage: self model singleImage to: name.