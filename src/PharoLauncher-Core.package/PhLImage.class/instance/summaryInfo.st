printing
summaryInfo
	| output |
	
	output := WriteStream on: String new.
	
	output nextPutAll: 'Last modified: '.
	self file modificationTime printOn: output.
	output 
		cr;
		nextPutAll: self file parent fullName;
		cr; cr.
	
	output nextPutAll: self description.
		
	^output contents