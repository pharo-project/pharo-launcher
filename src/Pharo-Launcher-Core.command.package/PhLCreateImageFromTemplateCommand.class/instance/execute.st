action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (context isNewImageNameValid: name).
	context imageRepository extractTemplate: context singleTemplate to: name