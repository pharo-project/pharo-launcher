action
createTemplate
	| name |
	name := self newTemplateName.
	self
		ensure: (context isNewLocalTemplateNameValid: name).
	context templateRepository
		createLocalTemplateFrom: context singleImage
		named: name