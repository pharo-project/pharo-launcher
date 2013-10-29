instance creation
name: aString groups: anotherCollection
	^ self new
		setName: aString templates: #() groups: anotherCollection;
		yourself