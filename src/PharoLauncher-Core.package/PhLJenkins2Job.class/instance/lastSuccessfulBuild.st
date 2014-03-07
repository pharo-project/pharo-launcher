accessing
lastSuccessfulBuild
	^ PhLJenkins2Build
		newWithProperties:
			(Dictionary new
				at: 'number' put: self lastSuccessfulBuildNumber;
				at: 'url' put: (self url / 'lastSuccessfulBuild') printString;
				yourself)