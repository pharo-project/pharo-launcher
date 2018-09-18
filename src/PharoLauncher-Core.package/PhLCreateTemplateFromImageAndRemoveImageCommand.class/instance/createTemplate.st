action
createTemplate
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self
		ensure: (self model isNewLocalTemplateNameValid: name).
	self model templateRepository
		createLocalTemplateFrom: self model singleImage
		named: name