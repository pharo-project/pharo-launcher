runnnig
rename: aStringDirectory to: aString
	
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