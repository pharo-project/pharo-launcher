runnnig
run: aString
	OSProcess command: 
		(Smalltalk vm fullPath asString, 
		' ', 
		self imageDirectory pathString, 
		'/', 
		aString, 
		'.image').
	self quit.