accessing
templatesAndGroups
	| builds |
	builds := self builds.
	self lastSuccessfulBuildNumber ifNil: [ ^ builds ].
	Halt once.
	^ {(self lastSuccessfulBuild).
	(PhLJenkins2BuildGroup name: 'All builds' builds: builds)}