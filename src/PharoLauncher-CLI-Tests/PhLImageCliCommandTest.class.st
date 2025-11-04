Class {
	#name : 'PhLImageCliCommandTest',
	#superclass : 'PhLCliCommandTest',
	#category : 'PharoLauncher-CLI-Tests-Commands',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Commands'
}

{ #category : 'adding' }
PhLImageCliCommandTest >> addImageNamed: anImageName [
	^ self imageRepository addImageNamed: anImageName
]

{ #category : 'adding' }
PhLImageCliCommandTest >> addInputAnswer: anObject [

	self launcherModel consoleInputRequest
		addAnswer: anObject
]

{ #category : 'creation' }
PhLImageCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [
	| templateCategory |
	templateCategory := self launcherModel templateRepository
		newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	self launcherModel templateRepository
		setGroups: {templateCategory}
]

{ #category : 'creation' }
PhLImageCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [
	^ self launcherModel templateRepository
		createTemplateNamed: aName
		inCategory: aCategoryName
]

{ #category : 'creation' }
PhLImageCliCommandTest >> addTemplateNamed: aName shortName: aShortName inCategory: aCategoryName [ 
	^ self launcherModel templateRepository
		createTemplateNamed: aName
		shortName: aShortName
		inCategory: aCategoryName
]

{ #category : 'accessing' }
PhLImageCliCommandTest >> imageRepository [ 
	^ self launcherModel imageRepository
]

{ #category : 'adding' }
PhLImageCliCommandTest >> nbInputAnswerRead [

	^ self launcherModel consoleInputRequest nbInputAnswerRead
]

{ #category : 'running' }
PhLImageCliCommandTest >> setUp [

	super setUp.
	self useMockImagesRepository
]

{ #category : 'accessing' }
PhLImageCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]

{ #category : 'tests' }
PhLImageCliCommandTest >> testExecuteLauncherImageCommandToPrintHelp [
	|expectedPrintout|
	expectedPrintout := 'Usage: launcher image'.
	
	self assertCommand: #('launcher' 'image') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'image' 'help') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'image' '--help') toPrintHelpWith: expectedPrintout.

]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'running' }
PhLImageCliCommandTest >> useMockImagesRepository [

	self launcherModel imageRepository: PhLImagesMockRepo new
]
