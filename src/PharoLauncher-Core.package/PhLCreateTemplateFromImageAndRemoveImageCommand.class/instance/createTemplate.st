action
createTemplate
	| name |
	name := self newTemplateName.
	self
		ensure: (self model isNewLocalTemplateNameValid: name).
	self model templateRepository
		createLocalTemplateFrom: self model singleImage
		named: name