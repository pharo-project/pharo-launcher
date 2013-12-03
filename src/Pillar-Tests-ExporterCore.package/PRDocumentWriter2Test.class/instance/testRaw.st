tests
testRaw
	| html |
	html := PRRaw content: self rawText.
	self
		assertWriting: html
		includesText:
			self rawText