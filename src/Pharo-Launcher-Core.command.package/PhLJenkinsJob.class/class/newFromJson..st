instance creation
newFromJson: aJsonObject
	"Choose what kind of job to create by analysing aJsonObject content"

	| lastSuccessfulBuild jobClass |
	lastSuccessfulBuild := aJsonObject at: #lastSuccessfulBuild.
	jobClass := (lastSuccessfulBuild isEmptyOrNil or: [ (lastSuccessfulBuild includesKey: #runs) not ])
		ifTrue: [ PhLJenkinsSimpleJob ]
		ifFalse: [ PhLJenkinsMatrixJob ].
	^ jobClass new
		initializeFromJson: aJsonObject;
		yourself