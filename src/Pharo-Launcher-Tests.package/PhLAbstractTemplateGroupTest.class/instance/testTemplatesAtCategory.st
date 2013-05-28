tests
testTemplatesAtCategory
	| group |
	group := self defaultTemplateGroup.
	self
		assert: ((group templatesAtCategory: 'c1') collect: #name) asSet
		equals: #('t1' 't3') asSet.
	self
		assert: ((group templatesAtCategory: 'c2') collect: #name) asSet
		equals: #('t1' 't2') asSet.
	self
		assert: ((group templatesAtCategory: 'c3') collect: #name) asSet
		equals: #('t2' 't3') asSet