tests
testNewLine
	| ston configuration |
	ston := '{ #newLine : #crlf }'.
	configuration := self fromString: ston.
	self assert: configuration newLine equals: String crlf.
	
	ston := '{ #newLine : ''my newline'' }'.
	configuration := self fromString: ston.
	self assert: configuration newLine equals: 'my newline'.
	configuration newLine: 'another'.
	self assert: configuration newLine equals: 'another'