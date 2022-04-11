Class {
	#name : #PhLImageLaunchCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageFromDiskShouldRaiseNotFound [
	| memoryFileSystem command location |
	command := PhLImageLaunchCliCommand with: context.
	memoryFileSystem := FileSystem memory.
	DiskStore
		currentFileSystem: memoryFileSystem
		during: [ location := (memoryFileSystem root / 'non-existing.image') ensureCreateFile.
			self should: [ command findImage: '/wrong/path' ] raise: NotFound ]
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageFromDiskShouldSucceed [
	| memoryFileSystem command location |
	command := PhLImageLaunchCliCommand with: context.
	memoryFileSystem := FileSystem memory.
	DiskStore
		currentFileSystem: memoryFileSystem
		during: [ 
			location := (memoryFileSystem root / 'existing.image') ensureCreateFile.
			self
				shouldnt: [ command findImage: location fullName ]
				raise: NotFound ]
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageShouldSucceed [
	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: #('launcher' 'image' 'launch' 'myImage1').
	
	self assert: self errorString equals:''.
	self assertSuccess.  
	self assert: image isLaunched. 
	self deny: image hasInitializationScript 

	
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageTooManyArguments [

	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: #('launcher' 'image' 'launch' '4' 'myImage1').
	 
	self assert: (self errorString includesSubstring: 'Unrecognized arguments: myImage1').
	self assertFailure.  
	self deny: image isLaunched. 

	

	
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWithInitializationScript [

	| image script |
	
	image := self addImageNamed: 'myImage1'.
	script := (FileLocator temp/ 'foo.st') ensureCreateFile.
	
	self runCommand: {'launcher' . 'image' . 'launch' . 'myImage1' . '--script' . script fullName}.
	 
	script ensureDelete.
	self assert: image isLaunched.
	self assert: image initializationScript equals: script asFileReference.
	

	
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWithNonExistingScriptShouldGiveErrorMessage [
	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: {'launcher' . 'image' . 'launch' . 'myImage1' . '--script' . 'nonExistingScript.st'}.
	 
	self deny: image isLaunched.
	self assert: self errorString equals: 'script not found' 
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWithScriptWhithoutStExtentionShouldGiveErrorMessage [
	| image script |
	script := Smalltalk imageFile asFileReference.	"need a non st file"
	image := self addImageNamed: 'myImage1'.
	
	self
		runCommand:
			{'launcher'. 'image'. 'launch'. 'myImage1'. '--script'. script fullName}.
			
	self deny: image isLaunched.
	self assert: self errorString equals: 'wrong script extension'
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWrongImageName [

	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: #('launcher' 'image' 'launch' 'wrongImageName').
	 
	self assert: (self errorString includesSubstring: 'Please enter a correct local image.').
	self deny: image isLaunched. 

	

	
]
