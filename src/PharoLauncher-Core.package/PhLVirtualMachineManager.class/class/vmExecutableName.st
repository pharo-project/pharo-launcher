accessing
vmExecutableName
	Smalltalk os isUnix ifTrue: [ ^ 'pharo' ].
	Smalltalk os isWindows ifTrue: [ ^ 'Pharo.exe' ].
	^ 'Pharo'