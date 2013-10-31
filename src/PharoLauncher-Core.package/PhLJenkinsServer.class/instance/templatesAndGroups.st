accessing
templatesAndGroups
	^ (self jobs at: #jobs) collect: [ :jsonJob | PhLJenkinsJob newFromJson: jsonJob ]