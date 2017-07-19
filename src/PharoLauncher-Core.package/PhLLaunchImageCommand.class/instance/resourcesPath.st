accessing
resourcesPath
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].