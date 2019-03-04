Class {
	#name : #PhLLaunchImageTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #resources }
PhLLaunchImageTest >> pharo6ImageResource [
	
	| resource tempArchive |
	resource := FileLocator localDirectory / 'test-resources'/ 'pharo6'.
	resource exists ifTrue: [ ^ resource children detect: [ :e | e extension = 'image' ] ].
	
	tempArchive := (FileLocator temp / 'image-archive.zip') nextVersion.
	
	[ZnClient new
		signalProgress: true;
		url: 'http://files.pharo.org/image/60/latest.zip';
		enforceHttpSuccess: true;
		downloadTo: tempArchive;
		yourself.
	
	ZipArchive new 
		readFrom: tempArchive;
		extractAllTo: resource.
	^ resource children detect: [ :e | e extension = 'image' ] ] ensure: [ 
		tempArchive ensureDeleteAll ]
]

{ #category : #tests }
PhLLaunchImageTest >> runCaseManaged [

	^ self runCase
]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchImageIsSuccess [

	| image result |
	[image := PhLImage location: self pharo6ImageResource.
	result := image launch.
	
	self assert: result isRunning ] ensure: [ 
		result ifNotNil: #terminate.
	]
	
]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchImageWithDefaultConfigurationIsSuccess [

	| image result |
	[image := PhLImage location: self pharo6ImageResource.
	result := image launchWithConfiguration: PhlLaunchConfiguration default.
	
	self assert: result isRunning ] ensure: [ 
		result ifNotNil: #terminate.
	]
	
]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchImageWithLaunchConfiguration [

	| image result |
	image := PhLImage location: self pharo6ImageResource.
	result := image launchWithConfiguration: (PhlLaunchConfiguration
		command: '{vm} --headless {image} eval "''testfile'' asFileReference writeStream" ').
	
	1 second wait.
	result terminate.
	
	self assert: (self pharo6ImageResource parent / 'testfile') exists.
	(self pharo6ImageResource parent / 'testfile') ensureDelete.
]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchUnicodeImageNameOnWin32ThrowsUnsupportedCharacterError [

	| image newTarget |

	[ newTarget := self pharo6ImageResource parent parent / 'Ω≈ç√∫˜µ≤≥÷'.
	self pharo6ImageResource parent copyAllTo: newTarget.
	image := PhLImage location: (newTarget children detect: [ :e | e extension = 'image' ]).
	self should: [ image launch ] raise: PhLNotSupportedCharacterError ]
		ensure: [ newTarget ensureDeleteAll ]
]
