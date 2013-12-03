asserting
assertWriting: aDocumentItem includesTexts: aCollection
	| resultString |
	resultString := self write: aDocumentItem.
	aCollection do: [ :testString | self assert: resultString includesSubstring: testString ]