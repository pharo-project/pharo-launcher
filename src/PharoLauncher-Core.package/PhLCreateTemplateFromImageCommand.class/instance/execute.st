action
execute
	| name |
	name := self newTemplateName.
	self ensure: name isEmptyOrNil not.
	context templateRepository createLocalTemplateFrom: context singleImage named: name