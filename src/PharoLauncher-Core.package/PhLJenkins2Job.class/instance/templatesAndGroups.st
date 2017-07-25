accessing
templatesAndGroups
	| builds |
	builds := self builds.
	self lastSuccessfulBuildNumber ifNil: [ ^ builds ].
	^ {(self lastSuccessfulBuild).
	(PhLJenkins2BuildGroup name: 'All builds' builds: builds)}