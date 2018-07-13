tests
testJobWithSuccessfulBuild
	| job lastSuccessfulBuild |
	self setUpResponse: self oneBuildResponse.
	job := self newJobWithSuccessfulBuild.
	self assert: job builds size equals: 1.
	self assert: job builds first number equals: self lastSuccessfulBuildNumber.
	self assert: job lastSuccessfulBuildNumber equals: self lastSuccessfulBuildNumber.
	lastSuccessfulBuild := job lastSuccessfulBuild.
	self assert: lastSuccessfulBuild number equals: self lastSuccessfulBuildNumber.
	
	"This assertion makes sure the url of the lastSuccessfulBuild will always refer to the latest successful build."
	self assert: lastSuccessfulBuild url lastPathSegment equals: 'lastSuccessfulBuild'