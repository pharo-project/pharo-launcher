tests
testBoldFormat
	| html |
	html := self addText: 'foo' to: PRBoldFormat new.
	self
		assertWriting: html
		includesTexts:
			{self boldFoo}