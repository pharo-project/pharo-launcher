instance creation
newJobWithNoSuccessfulBuild
	^ PhLJenkins2Job
		newWithProperties:
			(Dictionary new
				at: 'url' put: 'url' asUrl;
				at: 'name' put: 'thejob';
				yourself)