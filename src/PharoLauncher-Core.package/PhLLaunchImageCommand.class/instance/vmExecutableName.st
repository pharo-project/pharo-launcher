as yet unclassified
vmExecutableName
	^ Smalltalk os isUnix
			ifTrue: [ 'pharo' ]
			ifFalse: [ 'Pharo' ]