Extension { #name : #FileReferenceTest }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileReferenceTest >> testAsFileLocatorOrReferenceReturnsALocatorWhenStringRefersToAKnownOrigin [
	| fileRef locator |
	fileRef := (FileLocator home / 'foo') asFileReference.
	
	locator := fileRef asFileLocatorOrReference.
		
	self
		assert: locator origin
		equals: #home.
	self
		assert: locator fullName
		equals: fileRef fullName.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileReferenceTest >> testAsFileLocatorOrReferenceReturnsAReferenceWhenStringDoesNotReferToAKnownOrigin [
	| fileRef result |
	fileRef := '/foo' asFileReference.
	
	result := fileRef asFileLocatorOrReference.
	
	self
		assert: result
		equals: fileRef.
]
