printing
description
	| dirName f |
	dirName := self file parent fullName.
	f := (dirName , '/description.txt') asFileReference.
	
	^ f exists
		ifTrue: [ f contents withNoLineLongerThan: 80 ]
		ifFalse: [ 'There is no description.txt' ]