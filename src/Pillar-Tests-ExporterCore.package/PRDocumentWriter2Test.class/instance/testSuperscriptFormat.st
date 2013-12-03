tests
testSuperscriptFormat
	| html |
	html := self addText: 'foo' to: PRSuperscriptFormat new.
	self
		assertWriting: html
		includesTexts:
			{self superscriptFoo}