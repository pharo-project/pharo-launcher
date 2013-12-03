tests
testUnorderedList
	| html |
	html := PRUnorderedList new
		add: (self addText: '1' to: PRListItem new);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self unorderedListBegin).
			(self listItemWith1)}