tests
testStrikethroughFormat
	| html |
	html := self addText: 'foo' to: PRStrikethroughFormat new.
	self
		assertWriting: html
		includesTexts:
			{self strikethroughFoo}