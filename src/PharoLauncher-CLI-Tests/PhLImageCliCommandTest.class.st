Class {
	#name : #PhLImageCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLImageCliCommandTest >> addImageNamed: anImageName [
	^ self imageRepository addImageNamed: anImageName
]

{ #category : #accessing }
PhLImageCliCommandTest >> imageRepository [ 
	^ self launcherModel imageRepository
]

{ #category : #running }
PhLImageCliCommandTest >> setUp [

	super setUp.
	self useMockImagesRepository
]

{ #category : #accessing }
PhLImageCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]

{ #category : #tests }
PhLImageCliCommandTest >> testExecuteLauncherImageCommandToPrintHelp [
	|expectedPrintout|
	expectedPrintout := 'Usage: launcher image'.
	
	self assertCommand: #('launcher' 'image') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'image' 'help') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'image' '--help') toPrintHelpWith: expectedPrintout.

]

{ #category : #tests }
PhLImageCliCommandTest >> testFindImageFromDiskShouldRaiseNotFound [
	| memoryFileSystem command location |
	command := (PhLImageLaunchCliCommand asCliCommand activationWith: #('launch')) command.
	command setContext: context.
	memoryFileSystem := FileSystem memory.
	DiskStore
		currentFileSystem: memoryFileSystem
		during: [ location := (memoryFileSystem root / 'non-existing.image') ensureCreateFile.
			self should: [ command findImage: '/wrong/path' ] raise: NotFound ]
]

{ #category : #tests }
PhLImageCliCommandTest >> testFindImageFromDiskShouldSucceed [
	| memoryFileSystem command location |
	command := (PhLImageLaunchCliCommand asCliCommand activationWith: #('launch')) command.
	command setContext: context.
	memoryFileSystem := FileSystem memory.
	DiskStore
		currentFileSystem: memoryFileSystem
		during: [ 
			location := (memoryFileSystem root / 'existing.image') ensureCreateFile.
			self
				shouldnt: [ command findImage: location fullName ]
				raise: NotFound ]
]

{ #category : #running }
PhLImageCliCommandTest >> useMockImagesRepository [

	self launcherModel imageRepository: PhLImagesMockRepo new
]
