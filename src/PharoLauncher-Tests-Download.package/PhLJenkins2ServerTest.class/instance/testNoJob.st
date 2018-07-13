tests
testNoJob
	self setUpResponse: self noJobsResponse.
	self assert: self newInstance jobs isEmpty