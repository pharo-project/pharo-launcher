instance creation
emptyBuild
	^ PhLJenkins2Build
		newWithProperties:
			(Dictionary new
				at: 'number' put: self buildNumber;
				at: 'url' put: self buildUrlString;
				yourself)