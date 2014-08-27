printing
summaryInfo
	| dirName f output |
	
	dirName := self file parent fullName.
	f := (dirName , '/description.txt') asFileReference.
	
	output := WriteStream on: String new.
	
	output nextPutAll: 'Last modified: '.
	self file modificationTime printOn: output.
	output cr; cr.
	
	output nextPutAll: (f exists
		ifTrue: [ f contents withNoLineLongerThan: 80 ]
		ifFalse: [ dirName, ' has no description.txt' ]).
		
	^output contents