"
A presenter for Pharo Launcher images used for test purposes
"
Class {
	#name : #PhLTestImagesPresenter,
	#superclass : #PhLImagesPresenter,
	#instVars : [
		'request',
		'selection',
		'templateRepository',
		'fileSystem'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #sorting }
PhLTestImagesPresenter >> clickOnColumnHeaderAt: anIndex [
	imageTable clickOnColumnHeaderAt: anIndex
]

{ #category : #configuring }
PhLTestImagesPresenter >> createImageNamed: aName [
	^ self createImageNamed: aName in:  (fileSystem root / aName)
]

{ #category : #configuring }
PhLTestImagesPresenter >> createImageNamed: aName in: aFolder [
	| imageFile |
	imageFile := aFolder / (aName , '.image').
	aFolder ensureCreateDirectory.
	imageFile binaryWriteStreamDo: 
		[ :stream | 
		(ZnEndianessReadWriteStream on: stream ) 
			nextLittleEndianNumber: 4 
			put: PhLVirtualMachineManager imageFormat32bits "supportedImageFormat" ].
	(aFolder / (aName , '.changes')) ensureCreateFile.
	(aFolder / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	^ imageFile
]

{ #category : #private }
PhLTestImagesPresenter >> fileSystem [
	^ fileSystem
]

{ #category : #'api - selection' }
PhLTestImagesPresenter >> hasSingleImageSelected [
	^ super hasSingleImageSelected or: [ selection notNil ]
]

{ #category : #accessing }
PhLTestImagesPresenter >> imageLabel [
	^ descriptionPanel imageLabel label
]

{ #category : #accessing }
PhLTestImagesPresenter >> imageNames [
	^ imageTable items collect: #name
]

{ #category : #initialization }
PhLTestImagesPresenter >> initialize [
	fileSystem := FileSystem memory.
	self model: (PhLDirectoryBasedImageRepository forDirectory: fileSystem root).
	templateRepository := PhLTemplateGroupTestRepository new.
	self application: (PharoLauncherApplication new
		imageRepository: self model;
		instVarNamed: 'imagesPresenter' put: self;
		yourself).
	self createImageNamed: self singleImageName.
	super initialize.

	self createImageNamed: self singleImageName.
	request := PhLTestRequest new.
]

{ #category : #accessing }
PhLTestImagesPresenter >> launchConfigurations [
	^ launchConfigurationList listItems allButFirst
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newConfirmation [
	^ request := PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newFileRequest [
	^ request
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newInformation [
	self flag: 'TODO: spec should offer a way to open the inform dialog and accept it.'.

	^ PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newRequest [
	^ request
]

{ #category : #updating }
PhLTestImagesPresenter >> refreshLaunchConfigurationList [

	launchConfigurationList ifNotNil: [ super refreshLaunchConfigurationList ]
]

{ #category : #accessing }
PhLTestImagesPresenter >> request [

	^ request
]

{ #category : #configuring }
PhLTestImagesPresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : #selection }
PhLTestImagesPresenter >> selectedLaunchConfiguration [
	^ launchConfigurationList 
		ifNil: [ self singleImage defaultLaunchConfiguration ]
		ifNotNil: [ launchConfigurationList selectedItem  ifNil: [ self singleImage defaultLaunchConfiguration ] ]
]

{ #category : #configuring }
PhLTestImagesPresenter >> selection: aListOfImages [
	selection := aListOfImages
]

{ #category : #configuring }
PhLTestImagesPresenter >> selectionNames: aListOfImageNames [
	selection := aListOfImageNames collect: [ :name | PhLImage location: fileSystem root / name ].
]

{ #category : #'api - accessing' }
PhLTestImagesPresenter >> singleImage [ 
	^ [ super singleImage ]
		on: SubscriptOutOfBounds "no selection in real presenter"
		do: [ :error |
			 selection 
				ifNil: [ error pass ]
				ifNotNil: [ selection first ] ]
]

{ #category : #selection }
PhLTestImagesPresenter >> singleImageName [
	^ 'TestImage'
]

{ #category : #'api - accessing' }
PhLTestImagesPresenter >> templateRepository [ 
	^ templateRepository
]

{ #category : #selecting }
PhLTestImagesPresenter >> unselectAll [
	imageTable unselectAll.
]
