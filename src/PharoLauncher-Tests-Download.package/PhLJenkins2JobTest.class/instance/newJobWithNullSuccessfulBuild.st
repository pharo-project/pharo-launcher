instance creation
newJobWithNullSuccessfulBuild
	^ PhLJenkins2Job
		newWithProperties:
			(Dictionary new
				at: 'url' put: 'url' asUrl;
				at: 'name' put: 'thejob';
				at: 'lastSuccessfulBuild' put: nil;
				yourself)