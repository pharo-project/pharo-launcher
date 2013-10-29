tests
testTemplatesAndGroups
	| group templatesAndGroups |
	group := self newGroup.
	templatesAndGroups := group templatesAndGroups.
	self assert: templatesAndGroups size equals: 2.	"<- 2 archive links in exampleContent"
	self assert: (templatesAndGroups noneSatisfy: [ :template | template isTemplateGroup ]).
	self assert: (templatesAndGroups collect: #name) asSet equals: #('bla1' 'bla2') asSet