instance creation
emptyLastSuccessfulBuild
	^ PhLJenkins2Build
		newWithProperties:
			(Dictionary new
				at: 'number' put: self buildNumber;
				at: 'url' put: self lastSuccessfulBuildUrlString;
				yourself)