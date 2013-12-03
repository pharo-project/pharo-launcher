tests
testSimpleConfiguration
	| ston configuration |
	ston := '{ #headingLevelOffset : 2 }'.
	configuration := self fromString: ston.
	self assert: configuration headingLevelOffset equals: 2