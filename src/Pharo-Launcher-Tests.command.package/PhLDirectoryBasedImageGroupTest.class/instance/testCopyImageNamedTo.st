tests-action
testCopyImageNamedTo
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group copyImageNamed: 'test' to: 'test2'.
	self assert: group imageNames asSet equals: #('test' 'test2') asSet.
	