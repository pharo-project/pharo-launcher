runnnig
run: anElement
	OSProcess command: 
		(Smalltalk vm fullPath asString, 
		' ', 
		FileSystem disk workingDirectory pathString, 
		'\', 
		anElement asString).