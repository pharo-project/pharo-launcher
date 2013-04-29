runnnig
run: anElement
	OSProcess command: 
		(Smalltalk vm fullPath asString, 
		' ', 
		anElement url asString).
	self quit.