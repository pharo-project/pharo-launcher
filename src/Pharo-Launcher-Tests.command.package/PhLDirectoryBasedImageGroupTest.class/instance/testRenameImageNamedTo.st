tests-action
testRenameImageNamedTo
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group renameImageNamed: 'test' to: 'test2'.
	self assert: group imageNames asSet equals: #('test2') asSet.
	