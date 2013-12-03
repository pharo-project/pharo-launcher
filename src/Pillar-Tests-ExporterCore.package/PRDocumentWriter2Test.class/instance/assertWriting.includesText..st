asserting
assertWriting: aDocumentItem includesText: aString
	| result |
	result := self write: aDocumentItem.
	self assert: result includesSubstring: aString