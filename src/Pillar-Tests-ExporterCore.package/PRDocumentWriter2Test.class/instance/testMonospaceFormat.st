tests
testMonospaceFormat
	| html |
	html := self addText: 'foo' to: PRMonospaceFormat new.
	self
		assertWriting: html
		includesTexts:
			{self monospaceFoo}