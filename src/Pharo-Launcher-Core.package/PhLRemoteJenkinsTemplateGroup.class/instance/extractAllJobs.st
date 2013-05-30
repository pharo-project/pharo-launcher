action
extractAllJobs
	^ ((Json readFrom: (url retrieveContents readStream)) at: #jobs)
			collect: [ :json | PhLJenkinsJob newFromJson: json ]