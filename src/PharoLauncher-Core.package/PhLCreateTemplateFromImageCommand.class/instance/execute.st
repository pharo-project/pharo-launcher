action
execute
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self ensure: name isNotEmpty.
	self model templateRepository createLocalTemplateFrom: self model singleImage named: name