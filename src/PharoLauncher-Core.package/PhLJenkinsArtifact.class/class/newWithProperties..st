instance creation
newWithProperties: json 
	^ self new
		setProperties: json;
		yourself