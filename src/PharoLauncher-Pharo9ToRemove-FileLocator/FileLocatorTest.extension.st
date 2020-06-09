Extension { #name : #FileLocatorTest }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocatorTest >> testCanCreateLocatorFromStringWhenDeepChild [
	| path |
	path := (FileLocator home / 'foo' / 'bar' / 'bee' / 'see') fullName.
	
	locator := FileLocator fromString: path ifNone: [ nil ].
	
	self
		assert: locator origin
		equals: #home.
	self
		assert: locator fullName
		equals: path.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocatorTest >> testCanCreateLocatorFromStringWhenDirectChild [
	| path |
	path := (FileLocator home / 'foo') fullName.
	
	locator := FileLocator fromString: path ifNone: [ nil ].
		
	self
		assert: locator origin
		equals: #home.
	self
		assert: locator fullName
		equals: path.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocatorTest >> testCanCreateLocatorFromStringWhenSamePath [
	| path |
	path := FileLocator home fullName.
	
	locator := FileLocator fromString: path ifNone: [ nil ].
	
	self
		assert: locator
		equals: FileLocator home.
	self
		assert: locator fullName
		equals: path.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocatorTest >> testFromPathReturnsBlockValueIfPathNotPartOfAnOrigin [
	| path |
	path := '/foo' asFileReference path.
	
	locator := FileLocator fromPath: path ifNone: [ nil ].
	
	self
		assert: locator
		equals: nil.
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocatorTest >> testGetRightLocatorWhenCreatingFromString [
	| path |
	path := (FileLocator documents / 'foo') fullName.

	locator := FileLocator fromString: path ifNone: [ nil ].

	self
		assert: locator origin
		equals: #documents.
	self
		assert: locator fullName
		equals: path.
]
