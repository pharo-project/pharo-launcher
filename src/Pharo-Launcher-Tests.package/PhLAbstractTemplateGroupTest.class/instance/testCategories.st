tests
testCategories
	| group |
	group := self defaultTemplateGroup.
	self assert: group categories size equals: 3.
	self assert: group categories asSet equals: #('c1' 'c2' 'c3') asSet.