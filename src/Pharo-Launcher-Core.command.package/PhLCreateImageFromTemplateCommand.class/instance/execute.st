action
execute
	| name |
	name := self newImageName.
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository extractTemplate: context singleTemplate to: name