"
A presenter for Pharo Launcher images used for test purposes
"
Class {
	#name : #PhLTestImagesPresenter,
	#superclass : #PhLImagesPresenter,
	#instVars : [
		'request',
		'selection',
		'templateRepository'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #sorting }
PhLTestImagesPresenter >> clickOnColumnHeaderAt: anIndex [
	imageTable clickOnColumnHeaderAt: anIndex
]

{ #category : #selection }
PhLTestImagesPresenter >> createImageNamed: aString [
	^ self model createImageNamed: aString 
]

{ #category : #selection }
PhLTestImagesPresenter >> createImageNamed: aString in: aPathString [
	^ self model createImageNamed: aString in: aPathString
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
	self model: PhLTestImageRepository new.
	templateRepository := PhLTemplateTestRepository new.
	self
		application:
			(PharoLauncherApplication new
				imageRepository: self model;
				instVarNamed: 'imagesPresenter' put: self;
				yourself).
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
	^ PhLTestConfirmation new
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
	^ self model singleImageName
]

{ #category : #'api - accessing' }
PhLTestImagesPresenter >> templateRepository [ 
	^ templateRepository
]

{ #category : #selecting }
PhLTestImagesPresenter >> unselectAll [
	imageTable unselectAll.
]
