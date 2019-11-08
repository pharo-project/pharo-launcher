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

{ #category : #configuring }
PhLTestImagesPresenter >> createImageNamed: aName [
	| imageDirectory |
	imageDirectory := (fileSystem root / aName).
	imageDirectory ensureCreateDirectory.
	(imageDirectory / (aName , '.image')) 
		binaryWriteStreamDo: [:stream | stream nextPutAll: #(105 25 0 0)].
	(imageDirectory / (aName , '.changes')) ensureCreateFile.
	(imageDirectory / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].

]

{ #category : #private }
PhLTestImagesPresenter >> fileSystem [
	^ fileSystem
]

{ #category : #selection }
PhLTestImagesPresenter >> hasSingleImageSelected [
	^ self selectedImages size = 1
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
	super initialize.

	self createImageNamed: self singleImageName.
	self refresh.
	request := PhLTestRequest new.
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestImagesPresenter >> newRequest [
	^ request
]

{ #category : #configuring }
PhLTestImagesPresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : #selection }
PhLTestImagesPresenter >> selectedImages [
	^ selection 
		ifNotNil: [ selection isCollection
			ifTrue: [ selection ]
			ifFalse: [ { selection } ] ]
		ifNil: { self singleImage }
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
PhLTestImagesPresenter >> singleImage [
	^ selection ifNil: [ PhLImage location: fileSystem root / self singleImageName / (self singleImageName , '.image') ]
]

{ #category : #selection }
PhLTestImagesPresenter >> singleImageName [
	^ 'TestImage'
]

{ #category : #'api - accessing' }
PhLTestImagesPresenter >> templateRepository [ 
	^ templateRepository
]
