tests
testDefinitionList
	| html |
	html := PRDefinitionList new
		add: (self addText: 'foo' to: PRTermItem new);
		add: (self addText: 'bar' to: PRDataItem new);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{self definitionListBegin.
			self termItemWithFoo.
			self dataItemWithBar}