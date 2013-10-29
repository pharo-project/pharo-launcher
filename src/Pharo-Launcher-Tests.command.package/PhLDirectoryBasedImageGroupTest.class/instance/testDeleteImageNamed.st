tests-action
testDeleteImageNamed
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group deleteImageNamed: 'test'.
	self assert: group imageNames isEmpty