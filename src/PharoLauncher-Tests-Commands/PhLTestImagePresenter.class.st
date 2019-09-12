"
A presenter for Pharo Launcher images used for test purposes
"
Class {
	#name : #PhLTestImagePresenter,
	#superclass : #PhLImagesPresenter,
	#instVars : [
		'request',
		'selection',
		'templateRepository',
		'fileSystem'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #private }
PhLTestImagePresenter >> createImageNamed: aName [
	| imageDirectory |
	imageDirectory := (fileSystem root / aName).
	imageDirectory ensureCreateDirectory.
	(imageDirectory / (aName , '.image')) 
		binaryWriteStreamDo: [:stream | stream nextPutAll: #(105 25 0 0)].
	(imageDirectory / (aName , '.changes')) ensureCreateFile.
	(imageDirectory / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].

]

{ #category : #private }
PhLTestImagePresenter >> fileSystem [
	^ fileSystem
]

{ #category : #selection }
PhLTestImagePresenter >> hasSingleImageSelected [
	^ self selectedImages size = 1
]

{ #category : #initialization }
PhLTestImagePresenter >> initialize [
	fileSystem := FileSystem memory.
	self model: (PhLDirectoryBasedImageRepository forDirectory: fileSystem root).
	templateRepository := PhLTemplateGroupTestRepository new.
	self application: PharoLauncherApplication new.
	self createImageNamed: self singleImageName.	
	request := PhLTestRequest new.
]

{ #category : #'user interaction' }
PhLTestImagePresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestImagePresenter >> newRequest [
	^ request
]

{ #category : #configuring }
PhLTestImagePresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : #selection }
PhLTestImagePresenter >> selectedImages [
	^ selection 
		ifNotNil: [ selection isCollection
			ifTrue: [ selection ]
			ifFalse: [ { selection } ] ]
		ifNil: { self singleImage }
]

{ #category : #configuring }
PhLTestImagePresenter >> selection: aListOfImages [
	selection := aListOfImages
]

{ #category : #configuring }
PhLTestImagePresenter >> selectionNames: aListOfImageNames [
	selection := aListOfImageNames collect: [ :name | PhLImage location: fileSystem root / name ].
]

{ #category : #selection }
PhLTestImagePresenter >> singleImage [
	^ selection ifNil: [ PhLImage location: fileSystem root / self singleImageName / (self singleImageName , '.image') ]
]

{ #category : #selection }
PhLTestImagePresenter >> singleImageName [
	^ 'TestImage'
]

{ #category : #'api - accessing' }
PhLTestImagePresenter >> templateRepository [ 
	^ templateRepository
]
