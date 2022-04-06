Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir',
		'process',
		'runCommand',
		'image',
		'recreateCommand'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #helper }
PhLLaunchImageCommandTest >> addInitializationScriptToImage [
	image initializationScript: self initScript
]

{ #category : #helper }
PhLLaunchImageCommandTest >> initScript [
	^ FileSystem memory root / 'foo.st'
]

{ #category : #helper }
PhLLaunchImageCommandTest >> launchImage [
	self selectImage.
	process ifNotNil: [ self error: 'Currently one execution of image per test case.' ].
	process := runCommand execute
]

{ #category : #helper }
PhLLaunchImageCommandTest >> recreateImage [
	recreateCommand execute.
	self selectImage.
	^ presenter selectedImages anyOne
]

{ #category : #helper }
PhLLaunchImageCommandTest >> selectImage [
	presenter
		unselectAll;
		selectImageAt: 1
]

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	super setUp.

	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory.
	
	runCommand := PhLLaunchImageCommand new.
	runCommand context: presenter.
	recreateCommand := PhLRecreateImageCommand new.
	recreateCommand context: presenter.
	
	image := presenter singleImage.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	image 
		originTemplate: (PhLTestTemplatesPresenter new createLocalTemplateNamed: 'testTemplate');
		launchConfigurations: { PhLTestLaunchConfiguration withImage: image }.

]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [

	imageDir ensureDeleteAll.
	(process isNotNil and: [ process isRunning ]) 
		ifTrue: [ process terminate ].
	super tearDown
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testAttachingAnInitializationScriptIsOk [
	
	self addInitializationScriptToImage.
	
	self assert: image initializationScript isNotNil
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testAttachingInitializationScriptSetFlagToShouldRun [

	self addInitializationScriptToImage.
	
	self assert: image shouldRunInitializationScript.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImage [
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
		
	presenter 
		unselectAll;
		selection: { image }.

	image addLaunchConfiguration: 
		(image defaultLaunchConfiguration 
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself).
		
	process := runCommand execute.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testExecutingImageWithScriptShouldSetFlagToShouldNotRun [

	self addInitializationScriptToImage.
	self launchImage.
	
	self deny: image shouldRunInitializationScript.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testRecreateAnImageWithoutOpeningItShouldStillExecuteScript [

	| recreatedImage |
	self addInitializationScriptToImage.
	recreatedImage := self recreateImage.
	
	self assert: recreatedImage shouldRunInitializationScript.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testRecreateAnOpenedImageShouldStillExecuteScript [

	| recreatedImage |
	self addInitializationScriptToImage.
	self launchImage.
	recreatedImage := self recreateImage.
	
	self assert: recreatedImage shouldRunInitializationScript
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testRunningAnImageRemovesTheInitializationScript [
	self addInitializationScriptToImage.
	image := self recreateImage.
	
	self assert: image initializationScript path equals: self initScript path
]
