tests
testWith1Job
	| job server |
	self setUpResponse: self oneJobResponse.
	server := self newInstance.
	self assert: server jobs size equals: 1.
	job := server jobs first.
	self assert: job name equals: self defaultJobName.
	self assert: job url equals: self defaultJobUrlString asUrl