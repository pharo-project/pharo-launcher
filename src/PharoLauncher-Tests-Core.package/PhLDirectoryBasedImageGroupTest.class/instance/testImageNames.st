tests-action
testImageNames
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.