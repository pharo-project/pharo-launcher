instance creation
name: aString zipFile: aFileReference
	^ self new 
		setName: aString zipFile: aFileReference;
		yourself
		