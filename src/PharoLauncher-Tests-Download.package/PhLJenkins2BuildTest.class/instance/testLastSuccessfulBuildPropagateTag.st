tests
testLastSuccessfulBuildPropagateTag
	| run build |
	self setUpResponse: self oneRunResponse.
	build := self emptyLastSuccessfulBuild.
	self assert: build runs size equals: 1.
	run := build runs first.
	self assert: run url copy removeLastPathSegment lastPathSegment equals: 'lastSuccessfulBuild'