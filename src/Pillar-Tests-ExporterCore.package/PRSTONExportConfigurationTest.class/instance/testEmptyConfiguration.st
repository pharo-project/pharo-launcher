tests
testEmptyConfiguration
	| ston configuration |
	ston := '{  }'.
	configuration :=self fromString: ston.
	self assert: configuration headingLevelOffset equals: 0 "the default"