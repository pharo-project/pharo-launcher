accessing
runs
	|runs|
	runs := self query: PhLJenkins2Run.
	^ self isLastSuccessful
	ifTrue: [ runs do: [ :run | self propagateLastSuccessfulTagTo: run ] ]
	ifFalse: [ runs ]