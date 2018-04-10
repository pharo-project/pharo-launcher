tests
testBuildWithArtifacts
	| artifact |
	self setUpResponse: self oneArtifactResponse.
	self assert: self emptyBuild runs isEmpty.
	self assert: self emptyBuild artifacts size equals: 1.
	artifact := self emptyBuild artifacts first.
	self assert: artifact relativePath equals: self artifactRelativePath.
	self assert: artifact url equals: self buildUrlString asUrl / 'artifact' / self artifactRelativePath