tests
testOrderedList
	| html |
	html := PROrderedList new
		add: (self addText: '1' to: PRListItem new);
		yourself.
	self
		assertWriting: html
		includesTexts:
			{(self orderedListBegin).
			(self listItemWith1)}