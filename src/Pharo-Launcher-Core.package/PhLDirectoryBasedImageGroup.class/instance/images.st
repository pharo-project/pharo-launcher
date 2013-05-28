accessing
images
	^ images ifNil: [ self initializeImages ]