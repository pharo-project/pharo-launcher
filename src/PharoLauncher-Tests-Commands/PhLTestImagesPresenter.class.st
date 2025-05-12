"
A presenter for Pharo Launcher images used for test purposes
"
Class {
	#name : 'PhLTestImagesPresenter',
	#superclass : 'PhLImagesPresenter',
	#instVars : [
		'request',
		'selection'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'sorting' }
PhLTestImagesPresenter >> clickOnColumnHeaderAt: anIndex [
	imageTable clickOnColumnHeaderAt: anIndex
]

{ #category : 'image creation' }
PhLTestImagesPresenter >> createImageNamed: aString [
	^ self model createImageNamed: aString 
]

{ #category : 'image creation' }
PhLTestImagesPresenter >> createImageNamed: aString in: aPathString [
	^ self model createImageNamed: aString in: aPathString
]

{ #category : 'api - selection' }
PhLTestImagesPresenter >> hasSingleImageSelected [
	^ super hasSingleImageSelected or: [ selection isNotNil ]
]

{ #category : 'accessing' }
PhLTestImagesPresenter >> imageActionButtons [
	
	^ descriptionPanel imageActionButtons
]

{ #category : 'accessing' }
PhLTestImagesPresenter >> imageLabel [
	^ descriptionPanel imageLabel label
]

{ #category : 'accessing' }
PhLTestImagesPresenter >> imageNames [
	^ imageTable items collect: #name
]

{ #category : 'initialization' }
PhLTestImagesPresenter >> initialize [
	self application:
			(PhLTestApplication new
				imagesPresenter: self;
				yourself).
	self model: self application imageRepository.
	super initialize.

	self createImageNamed: self singleImageName.
	request := PhLTestRequest new.
]

{ #category : 'accessing' }
PhLTestImagesPresenter >> launchConfigurations [
	^ launchConfigurationList listItems allButFirst
]

{ #category : 'user interaction' }
PhLTestImagesPresenter >> newConfirmation [
	^ request := PhLTestConfirmation new
]

{ #category : 'user interaction' }
PhLTestImagesPresenter >> newFileRequest [
	^ request
]

{ #category : 'user interaction' }
PhLTestImagesPresenter >> newInformation [
	self flag: 'TODO: spec should offer a way to open the inform dialog and accept it.'.

	^ PhLTestConfirmation new
]

{ #category : 'user interaction' }
PhLTestImagesPresenter >> newRequest [
	^ request
]

{ #category : 'accessing' }
PhLTestImagesPresenter >> request [

	^ request
]

{ #category : 'configuring' }
PhLTestImagesPresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : 'configuring' }
PhLTestImagesPresenter >> selection: aListOfImages [
	selection := aListOfImages
]

{ #category : 'api - accessing' }
PhLTestImagesPresenter >> singleImage [ 
	^ [ super singleImage ]
		on: SubscriptOutOfBounds "no selection in real presenter"
		do: [ :error |
			 selection 
				ifNil: [ error pass ]
				ifNotNil: [ selection first ] ]
]

{ #category : 'api - selection' }
PhLTestImagesPresenter >> singleImageName [
	^ self model singleImageName
]

{ #category : 'api - accessing' }
PhLTestImagesPresenter >> templateRepository [ 
	^ application templateRepository
]

{ #category : 'api - selection' }
PhLTestImagesPresenter >> unselectAll [
	imageTable unselectAll.
]

{ #category : 'updating' }
PhLTestImagesPresenter >> updateImageDetails [

	descriptionPanel model: descriptionPanel model
]
