Extension { #name : #StringTest }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
StringTest >> testAsFileLocatorOrReferenceReturnsALocatorWhenStringRefersToAKnownOrigin [
	| pathString locator |
	pathString := (FileLocator home / 'foo') fullName.
	
	locator := pathString asFileLocatorOrReference.
		
	self
		assert: locator origin
		equals: #home.
	self
		assert: locator fullName
		equals: pathString.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
StringTest >> testAsFileLocatorOrReferenceReturnsAReferenceWhenStringDoesNotReferToAKnownOrigin [
	| fileRef result |
	fileRef := '/foo' asFileReference.
	
	result := fileRef fullName asFileLocatorOrReference.
	
	self
		assert: result
		equals: fileRef.
]
