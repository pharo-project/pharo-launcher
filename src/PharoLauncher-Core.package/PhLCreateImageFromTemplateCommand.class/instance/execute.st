action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self ensure: (self model isNewImageNameValid: name).
	self model imageRepository extractTemplate: self model singleTemplate to: name