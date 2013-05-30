instance creation
newFromJson: aJsonObject
	| lastSuccessfulBuild |
	lastSuccessfulBuild := aJsonObject at: #lastSuccessfulBuild.
	^ ((lastSuccessfulBuild isEmptyOrNil or: [(lastSuccessfulBuild includesKey: #runs) not])
			ifTrue: [ PhLJenkinsSimpleJob ]
			ifFalse: [ PhLJenkinsMatrixJob ])
				new initializeFromJson: aJsonObject; yourself