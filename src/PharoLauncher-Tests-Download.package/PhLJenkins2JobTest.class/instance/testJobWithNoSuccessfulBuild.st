tests
testJobWithNoSuccessfulBuild
	self setUpResponse: self noBuildsResponse.
	self assert: self newJobWithNoSuccessfulBuild builds isEmpty