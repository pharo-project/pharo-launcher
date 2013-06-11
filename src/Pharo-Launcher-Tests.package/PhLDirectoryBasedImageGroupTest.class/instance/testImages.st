tests-action
testImages
	| group |
	group := self newGroupWithAnImage.
	self assert: group images size equals: 1.
	self assert: group images anyOne name equals: 'test'