private
propagateLastSuccessfulTagTo: aRun 
	| url |
	url := aRun url copy.
	url isDirectoryPath ifTrue: [ url := url removeLastPathSegment ].
	url := url removeLastPathSegment.
	url := url / 'lastSuccessfulBuild'.
	url closePath.
	aRun properties at: 'url' put: url