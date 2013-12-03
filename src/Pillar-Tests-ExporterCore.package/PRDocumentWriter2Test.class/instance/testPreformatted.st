tests
testPreformatted
	| html |
	html := self addText: 'foo' to: PRPreformatted new.
	self assertWriting: html includesTexts: {self preformattedFooBegin . self preformattedTextFoo}