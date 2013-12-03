tests
testUnderlineFormat
	| html |
	html := self addText: 'foo' to: PRUnderlineFormat new.
	self
		assertWriting: html
		includesTexts:
			{self underlineFoo}