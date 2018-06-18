printing
description
	| dirName f output |
	
	dirName := self file parent fullName.
	f := (dirName , '/description.txt') asFileReference.
	
	output := WriteStream on: String new.
	
	output nextPutAll: (f exists
		ifTrue: [ f contents withNoLineLongerThan: 80 ]
		ifFalse: [ 'There is no description.txt' ]).
		
	^output contents