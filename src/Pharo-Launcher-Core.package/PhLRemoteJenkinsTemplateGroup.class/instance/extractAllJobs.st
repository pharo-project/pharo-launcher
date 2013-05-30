action
extractAllJobs
	^ (self extractJsonJobList at: #jobs) collect: [ :jsonJob | PhLJenkinsJob newFromJson: jsonJob ]