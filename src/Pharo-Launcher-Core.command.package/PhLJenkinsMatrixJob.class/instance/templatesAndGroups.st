accessing
templatesAndGroups
	| build runs |
	build := json at: #lastSuccessfulBuild.
	build isEmptyOrNil
		ifTrue: [ ^ #() ].
	runs := build at: #runs.
	runs isEmptyOrNil
		ifTrue: [ ^ #() ].
	^ runs collect: [ :jsonRun | PhLJenkinsRun newFromJson: jsonRun ]