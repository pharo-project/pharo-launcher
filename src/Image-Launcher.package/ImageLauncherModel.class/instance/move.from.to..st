runnnig
move: aStringFile from: aStringOrigninalDirectory to: aStringDirectory
	
	OSProcess command: 
		('mv ', 
		aStringOrigninalDirectory ,
		'/',
		aStringFile, 
		' ', 
		aStringDirectory , 
		'/').