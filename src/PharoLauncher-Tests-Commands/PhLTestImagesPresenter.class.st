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
	imageFile binaryWriteStreamDo: [:stream | stream nextPutAll: #(105 25 0 0)].
	(aFolder / (aName , '.changes')) ensureCreateFile.
	(aFolder / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	^ imageFile
]

{ #category : #private }
PhLTestImagesPresenter >> fileSystem [
	^ fileSystem
]

{ #category : #acccessing }
PhLTestImagesPresenter >> imageLabel [
	^ descriptionPanel imageLabel label
]

{ #category : #acccessing }
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
	self refresh.
	request := PhLTestRequest new.
]

{ #category : #acccessing }
PhLTestImagesPresenter >> launchConfigurations [
	^ launchConfigurationList listItems allButFirst
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newFileRequest [
	^ request
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newRequest [
	^ request
]

{ #category : #updating }
PhLTestImagesPresenter >> refreshLaunchConfigurationList [
	launchConfigurationList ifNotNil: [ super refreshLaunchConfigurationList ]
]

{ #category : #configuring }
PhLTestImagesPresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : #selection }
PhLTestImagesPresenter >> selectedLaunchConfiguration [
	^ launchConfigurationList 
		ifNil: [ self singleImage defaultLaunchConfiguration ]
		ifNotNil: [ launchConfigurationList selectedItem ]
]

{ #category : #configuring }
PhLTestImagesPresenter >> selection: aListOfImages [
	selection := aListOfImages
]

{ #category : #configuring }
PhLTestImagesPresenter >> selectionNames: aListOfImageNames [
	selection := aListOfImageNames collect: [ :name | PhLImage location: fileSystem root / name ].
]

{ #category : #selection }
PhLTestImagesPresenter >> singleImageName [
	^ 'TestImage'
]

{ #category : #'api - accessing' }
PhLTestImagesPresenter >> templateRepository [ 
	^ templateRepository
]
