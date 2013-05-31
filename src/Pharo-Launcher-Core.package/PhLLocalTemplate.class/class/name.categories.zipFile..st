instance creation
name: aString categories: categories zipFile: aFileReference
	^ self new 
		setName: aString categories: categories zipFile: aFileReference;
		yourself
		