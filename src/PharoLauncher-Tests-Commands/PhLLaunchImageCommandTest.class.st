Class {
	#name : 'PhLLaunchImageCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'process',
		'image'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLLaunchImageCommandTest class >> resources [

	^ { PhLPharoStableImageResource }
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> addInitializationScriptToImage [

	image initializationScript: self initScript
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> denyApplicationHasError [

	presenter application hasError 
		ifTrue: [ self fail: presenter application error longDescription ]
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> initScript [
	^ (presenter application scriptsDirectory / 'foo.st') ensureCreateFile
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> launchImage [

	process ifNotNil: [ self error: 'Currently one execution of image per test case.' ].
	
	process := PhLLaunchImageCommand new
		context: presenter;
		execute
]

{ #category : 'private' }
PhLLaunchImageCommandTest >> performTest [

	PharoLauncherApplication useDefault: presenter application during: [ super performTest ]
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> recreateImage [
	PhLRecreateImageCommand new
		context: presenter;
		execute.
	self selectImage.
	^ presenter selectedImages anyOne
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> selectImage [
	presenter
		unselectAll;
		selectImageAt: 1
]

{ #category : 'running' }
PhLLaunchImageCommandTest >> setImageOriginTemplateAndLaunchConfiguration [
	image
		originTemplate:
			(presenter application templateRepository createLocalTemplateNamed: 'testTemplate');
		launchConfigurations:
			{ (PhLTestLaunchConfiguration withImage: image) }
]

{ #category : 'running' }
PhLLaunchImageCommandTest >> setUp [

	super setUp.

	presenter := PhLTestImagesPresenter new.
	image := presenter singleImage.
	self setImageOriginTemplateAndLaunchConfiguration.
	presenter updateImageDetails.
]

{ #category : 'running' }
PhLLaunchImageCommandTest >> tearDown [

	(process isNotNil and: [ process isRunning ]) 
		ifTrue: [ process terminate ].
	super tearDown
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testAttachingAnInitializationScriptIsOk [
	
	self addInitializationScriptToImage.
	
	self assert: image initializationScript isNotNil
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testAttachingInitializationScriptSetFlagToShouldRun [

	self addInitializationScriptToImage.
	
	self assert: image shouldRunInitializationScript.
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testCanLaunchImage [
	self timeLimit: 30 seconds.
	
	self useNewStableImageAndSetItAsSelectedImageInImagesPresenter.
	image launchConfigurations:
		{ image defaultLaunchConfiguration asLaunchConfiguration
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself }.
		
	self launchImage.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testExecutingImageWithScriptShouldSetFlagToShouldNotRun [

	self addInitializationScriptToImage.
	presenter selectLaunchConfiguration: image launchConfigurations first.
	self launchImage.
	
	self denyApplicationHasError.
	self deny: image shouldRunInitializationScript.
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testLaunchImageShouldRaiseExceptionWhenNoPharoVersionFile [
	
	image versionFile ensureDelete.

	self 
		should: [ image launch ]
		raise: PhLImageVersionFileNotFound
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testRecreateAnImageWithoutOpeningItShouldStillExecuteScript [

	| recreatedImage |

	self addInitializationScriptToImage.

	recreatedImage := self recreateImage.
	
	self assert: recreatedImage shouldRunInitializationScript.
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testRecreateAnOpenedImageShouldStillExecuteScript [

	| recreatedImage |

	self addInitializationScriptToImage.
	self launchImage.
	recreatedImage := self recreateImage.

	self assert: recreatedImage shouldRunInitializationScript
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testRecreatingAnImageKeepsTheInitializationScript [

	self addInitializationScriptToImage.
	
	image := self recreateImage.
	
	self assert: image initializationScript path equals: self initScript path
]

{ #category : 'tests' }
PhLLaunchImageCommandTest >> testRecreatingAnImageKeepsTheInitializationScriptOk [

	image := PhLPharoStableImageResource current newRepositoryWithImage.
	image
		originTemplate:
			(presenter application templateRepository createLocalTemplateNamed: 'testTemplate').
	presenter model: (PhLDirectoryBasedImageRepository forDirectory: image file parent parent).
	presenter refresh.
	presenter selectImage: image.
	image := presenter selectedImages first.
	
	self addInitializationScriptToImage.
	image := self recreateImage.
	
	self assert: image initializationScript path equals: self initScript path
]

{ #category : 'helper' }
PhLLaunchImageCommandTest >> useNewStableImageAndSetItAsSelectedImageInImagesPresenter [

	image := PhLPharoStableImageResource current newImage.
	presenter 
		unselectAll;
		selection: { image }
]
