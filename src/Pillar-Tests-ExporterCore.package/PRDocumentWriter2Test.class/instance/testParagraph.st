tests
testParagraph
	| html |
	html := self addText: 'foo' to: PRParagraph new.
	self assertWriting: html includesText: self paragraphFoo