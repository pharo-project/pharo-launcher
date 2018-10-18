"
I represent a Jenkins job. If I'm a simple job, artifacts are available directly. If I'm a matrix job, artefacts are available from runs.
"
Class {
	#name : #PhLJenkins2Build,
	#superclass : #PhLJenkins2WithArtifactsEntity,
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkins2Build class >> jsonName [
	^ 'builds'
]

{ #category : #testing }
PhLJenkins2Build >> isLastSuccessful [
	^ self url lastPathSegment = 'lastSuccessfulBuild'
]

{ #category : #accessing }
PhLJenkins2Build >> name [
	^ String streamContents: [:str |
		self isLastSuccessful 
			ifTrue: [ str nextPutAll: 'Latest sucessful build: ' ].
		str 
			nextPut: $#;
		 	print: self number]
]

{ #category : #private }
PhLJenkins2Build >> propagateLastSuccessfulTagTo: aRun [ 
	| url |
	url := aRun url copy.
	url isDirectoryPath ifTrue: [ url := url removeLastPathSegment ].
	url := url removeLastPathSegment.
	url := url / 'lastSuccessfulBuild'.
	url closePath.
	aRun properties at: 'url' put: url
]

{ #category : #accessing }
PhLJenkins2Build >> runs [
	|runs|
	runs := self query: PhLJenkins2Run.
	^ self isLastSuccessful
	ifTrue: [ runs do: [ :run | self propagateLastSuccessfulTagTo: run ] ]
	ifFalse: [ runs ]
]

{ #category : #accessing }
PhLJenkins2Build >> templatesAndGroups [
	^ super templatesAndGroups , self runs
]
