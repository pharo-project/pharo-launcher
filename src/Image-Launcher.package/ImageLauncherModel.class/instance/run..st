runnnig
run: anElement
	self halt.
	OSProcess command: 
		(Smalltalk vm fullPath asString, 
		' ', 
		FileSystem disk workingDirectory pathString, 
		'\', 
		anElement asString).