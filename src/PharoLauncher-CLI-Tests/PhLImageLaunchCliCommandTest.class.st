Class {
	#name : #PhLImageLaunchCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLImageLaunchCliCommandTest >> addInputAnswer: anObject [

	context pharoLauncherModel consoleInputRequest
		addAnswer: anObject
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageNoImageNameAllowsLaunchBySelectingImageInteractively [
	| image1 image2 |
	image1 := self addImageNamed: 'myImage1'. "#2"
	image2 := self addImageNamed: 'myImage2'. "#1"
	image2 lastModification: image1 lastModification + 1 day.
	self addInputAnswer: 'foo'. "Not a Number, will ask again"
	self addInputAnswer: '33'. "Number out of range, will ask again"
	self addInputAnswer: '1'.
	
	self runCommand: #('launcher' 'image' 'launch').
	 
	self assertSuccess. 
	"Assert image " 
	self assert: (self outputString includesSubstring:' myImage1').
	self assert: (self outputString includesSubstring:' myImage2').
	self assert: image2 isLaunched. 
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
	self assertFailure.
	self deny: image isLaunched.
	self assert: (self errorString includesSubstring:  'script for image not found') 
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWithScriptWhithoutStExtentionShouldGiveErrorMessage [
	| image script |
	script := Smalltalk imageFile asFileReference.	"need a non st file"
	image := self addImageNamed: 'myImage1'.

	self runCommand: {'launcher'. 'image'. 'launch'. 'myImage1'. '--script'. script fullName}.
	self assertFailure.
	self deny: image isLaunched.
	self assert: (self errorString includesSubstring: 'script has wrong file extension')
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageWrongImageName [

	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: #('launcher' 'image' 'launch' 'wrongImageName').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Please enter a correct local image.').
	self deny: image isLaunched. 

	

	
]
