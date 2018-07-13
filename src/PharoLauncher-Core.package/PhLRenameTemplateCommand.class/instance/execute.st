action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (self model isNewLocalTemplateNameValid: name).
	self model singleTemplate renameTo: name.
	self model templateRepositoryChanged