accessing
vmExecutableName
	^ Smalltalk os isUnix
			ifTrue: [ 'pharo' ]
			ifFalse: [ 'Pharo' ]