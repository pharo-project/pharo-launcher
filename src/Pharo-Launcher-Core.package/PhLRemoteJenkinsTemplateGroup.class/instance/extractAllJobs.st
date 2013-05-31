private
extractAllJobs
	"Return a list of PhLJenkinsJob created after querying my url"
	^ (self extractJsonJobList at: #jobs) collect: [ :jsonJob | PhLJenkinsJob newFromJson: jsonJob ]