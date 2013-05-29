action
launch
		OSProcess command: 
		('cd ', location parent pathString, ' && ', Smalltalk vm fullPath asString, 
		' ', 
		location basename).