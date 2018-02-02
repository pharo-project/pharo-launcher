tests
testSubscriptFormat
	| html |
	html := self addText: 'foo' to: PRSubscriptFormat new.
	self
		assertWriting: html
		includesTexts:
			{self subscriptFoo}