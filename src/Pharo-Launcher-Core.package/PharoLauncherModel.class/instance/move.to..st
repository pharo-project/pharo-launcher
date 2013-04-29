runnnig
move: aStringFile to: aStringDirectory
	
	| aString |
	OSProcess command: 
		('mv ', 
		aStringDirectory,
		'/*.image ', 
		aStringDirectory , 
		'/', 
		aString, '.image').
	OSProcess command: 
		('mv ', 
		aStringDirectory,
		'/*.changes ', 
		aStringDirectory , 
		'/', 
		aString, '.changes').