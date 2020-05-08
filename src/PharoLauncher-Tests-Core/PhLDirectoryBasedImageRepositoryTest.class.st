"
A PhLDirectoryBasedImageGroupTest is a test class for testing the behavior of PhLDirectoryBasedImageGroup
"
Class {
	#name : #PhLDirectoryBasedImageRepositoryTest,
	#superclass : #ClassTestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #coverage }
PhLDirectoryBasedImageRepositoryTest >> classToBeTested [
	^ PhLDirectoryBasedImageRepository
]

{ #category : #'instance creation' }
PhLDirectoryBasedImageRepositoryTest >> emptyGroup [
	^ self classToBeTested forDirectory: FileSystem memory workingDirectory
]

{ #category : #'instance creation' }
PhLDirectoryBasedImageRepositoryTest >> newGroupWithAnImage [
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	(baseDirectory / 'test') ensureCreateDirectory.
	(baseDirectory / 'test' / 'test.image') ensureCreateFile.
	(baseDirectory / 'test' / 'test.changes') ensureCreateFile.
	^ group
]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testCopyImageNamedTo [
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group copyImageNamed: 'test' to: 'test2'.
	self assert: group imageNames asSet equals: #('test' 'test2') asSet.
	
]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testDeleteImageNamed [
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group deleteImageNamed: 'test'.
	self assert: group imageNames isEmpty
]

{ #category : #tests }
PhLDirectoryBasedImageRepositoryTest >> testDirectoryForImageNamed [
	| group |
	group := self emptyGroup.
	self assert: group images isEmpty.
	self assert: group imageNames isEmpty.
]

{ #category : #tests }
PhLDirectoryBasedImageRepositoryTest >> testEmptyByDefault [
	| group |
	group := self emptyGroup.
	self assert: group images isEmpty.
	self assert: group imageNames isEmpty.
]

{ #category : #tests }
PhLDirectoryBasedImageRepositoryTest >> testIgnoreNonConformDirectories [
	| group baseDirectory |
	group := self emptyGroup.
	baseDirectory := group baseDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1') ensureCreateDirectory.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo.txt') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') delete.
	(baseDirectory / 'foo1' / 'foo1.changes') ensureCreateFile.
	self assert: group images size equals: 0.
	(baseDirectory / 'foo1' / 'foo1.image') ensureCreateFile.
	self assert: group images size equals: 1.
]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testImageNames [
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testImages [
	| group |
	group := self newGroupWithAnImage.
	self assert: group images size equals: 1.
	self assert: group images anyOne name equals: 'test'
]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testMakeUniqueImageName [
	
	{ 
	"	{ basename . 	expectedResult .	{existingNames} } "	
		{ '30444' .		'30444' . 			{ } } .
	 	{ '30444' .		'30444' . 			{ 'test' } } .
		{ '30444' .		'30444-01' .		{ 'test' . '30444' } } .
		{ '30444' .		'30444-02' .		{ 'test' . '30444' . '30444-01' } } .
		{ '30444' .		'30444-03' .		{ 'test' . '30444' . '30444-01' . '30444-02' } } .
		{ '30444' .		'30444-10' .		{ 'test' . '30444' . '30444-01' . '30444-09' } } .
		{ '30444' .		'30444-12' .		{ 'test' . '30444' . '30444-11' . '30444-09' } } .
		{ '30444' . 		'30444-12' .		{ 'test' . '30444' . '30444-11' . '30444-09' . '30444-test' . '30644-Case12954' } } .		
	} do:
	[ 	:testdata |  
		| basename expectedResult existingNames result |
		basename := testdata first.
		expectedResult := testdata second. 
		existingNames := testdata third.
		
		result := self emptyGroup makeUniqueImageName: basename among: existingNames.
		self assert: result equals: expectedResult.
	]
 


]

{ #category : #'tests-action' }
PhLDirectoryBasedImageRepositoryTest >> testRenameImageNamedTo [
	| group |
	group := self newGroupWithAnImage.
	self assert: group imageNames asSet equals: #('test') asSet.
	group renameImageNamed: 'test' to: 'test2'.
	self assert: group imageNames asSet equals: #('test2') asSet.
	
]
