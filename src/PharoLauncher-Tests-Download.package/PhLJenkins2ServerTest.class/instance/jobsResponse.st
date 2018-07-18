responses
jobsResponse
	^ 'jobs : {' , self simpleJob , ',' , self matrixJob , ',' , self jobWithNoBuild , ',' , self jobWithNoSuccessfulBuild
		, '}'