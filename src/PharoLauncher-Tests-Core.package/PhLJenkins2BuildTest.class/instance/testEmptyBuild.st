tests
testEmptyBuild
	self setUpResponse: '{}'.
	self assert: self emptyBuild artifacts isEmpty.
	self assert:self emptyBuild runs isEmpty.