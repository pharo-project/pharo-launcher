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
	
	self assert: result isSuccess ] ensure: [ 
		self halt.
	]
	
]
