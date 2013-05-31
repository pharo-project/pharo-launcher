accessing
templates
	^ self extractAllJobs gather: [ :job | self extractTemplatesFromJob: job ]