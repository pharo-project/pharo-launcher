action
execute
	| name |
	name := self newTemplateName.
	self ensure: name isEmptyOrNil not.
	self model templateRepository createLocalTemplateFrom: self model singleImage named: name