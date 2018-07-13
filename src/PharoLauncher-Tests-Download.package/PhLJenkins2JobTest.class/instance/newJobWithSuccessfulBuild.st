instance creation
newJobWithSuccessfulBuild
	^ PhLJenkins2Job
		newWithProperties:
			(Dictionary new
				at: 'url' put: 'url' asUrl;
				at: 'name' put: 'thejob';
				at: 'lastSuccessfulBuild'
					put:
						(Dictionary
								newFromPairs:
									{'number'.
									(self lastSuccessfulBuildNumber).
									'url'.
									(self lastSuccessfulBuildUrlString)});
				yourself)