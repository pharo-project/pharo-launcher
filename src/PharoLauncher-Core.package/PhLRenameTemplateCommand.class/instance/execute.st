action
execute
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (context isNewLocalTemplateNameValid: name).
	context singleTemplate renameTo: name.
	context templateRepositoryChanged