instance creation
name: aString url: anUrl categories: aCollection
	^ self new
		setName: aString url: anUrl categories: aCollection;
		yourself