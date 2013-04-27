runnnig
run: aString
	self halt.
	OSProcess command: 
		(Smalltalk vm fullPath asString, 
		' ', 
		self imageDirectory pathString, 
		'/', 
		aString, 
		'.image').