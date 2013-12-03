tests
testItalicFormat
	| html |
	html := self addText: 'foo' to: PRItalicFormat new.
	self
		assertWriting: html
		includesTexts:
			{self italicFoo}