accessing
runs
	^ ((json at: #lastSuccessfulBuild) at: #runs)
		collect: [ :jsonRun | PhLJenkinsRun newFromJson: jsonRun ]