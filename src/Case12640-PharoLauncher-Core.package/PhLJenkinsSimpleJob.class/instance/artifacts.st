accessing
artifacts
	| lastSuccessfulBuild artifacts |
	lastSuccessfulBuild := json at: #lastSuccessfulBuild.
	lastSuccessfulBuild isEmptyOrNil
		ifTrue: [ ^ #() ].
	artifacts := lastSuccessfulBuild at: #artifacts.
	^ self artifactsFromJson: artifacts