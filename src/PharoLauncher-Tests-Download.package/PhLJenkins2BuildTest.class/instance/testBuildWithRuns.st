tests
testBuildWithRuns
	| run |
	self setUpResponse: self oneRunResponse.
	self assert: self emptyBuild artifacts isEmpty.
	self assert: self emptyBuild runs size equals: 1.
	run := self emptyBuild runs first.
	self assert: run number equals: self runNumber