"
A spec application used for test purposes.
I can answer pre-arranged responses to UI requests.
"
Class {
	#name : 'PhLTestApplication',
	#superclass : 'PharoLauncherApplication',
	#instVars : [
		'requestAnswer',
		'requestAttributes'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'confirmation' }
PhLTestApplication >> confirm [
	^ true
]

{ #category : 'accessing' }
PhLTestApplication >> error [
	^ requestAttributes at: #error
]

{ #category : 'testing' }
PhLTestApplication >> hasError [
	^ requestAttributes includesKey: #error
]

{ #category : 'accessing' }
PhLTestApplication >> imageRepository [
	^ 	imageRepository ifNil: [ imageRepository := PhLTestImageRepository new ]
]

{ #category : 'accessing' }
PhLTestApplication >> imagesPresenter: aPhLImagesPresenter [
	imagesPresenter := aPhLImagesPresenter
]

{ #category : 'request' }
PhLTestApplication >> inform [
	"do nothing"
]

{ #category : 'initialization' }
PhLTestApplication >> initialize [ 

	requestAttributes := OrderedDictionary new.
]

{ #category : 'confirmation' }
PhLTestApplication >> label: aString [

	requestAttributes at: #label put: aString
]

{ #category : 'events' }
PhLTestApplication >> launchConfigurationEdited: aPhLLaunchConfiguration [ 
	"do nothing"
]

{ #category : 'confirmation' }
PhLTestApplication >> message: aString [ 
	
	requestAttributes at: #message put: aString
]

{ #category : 'confirmation' }
PhLTestApplication >> newConfirm [
	"do nothing"
]

{ #category : 'confirmation' }
PhLTestApplication >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : 'confirmation' }
PhLTestApplication >> newInform [
	"polymorphism with spec app"
	
	self newInformation 
]

{ #category : 'confirmation' }
PhLTestApplication >> newInformation [
	"do nothing"
]

{ #category : 'request' }
PhLTestApplication >> newRequest [
	"do nothing"
]

{ #category : 'ui' }
PhLTestApplication >> openModalWithParent: aWindow [

	"do nothing"
]

{ #category : 'ui' }
PhLTestApplication >> pushProgress: aString with: aFullBlockClosure [ 
	"do not display progress, only evaluate the block"
	aFullBlockClosure value: DummySystemProgressItem new
]

{ #category : 'request' }
PhLTestApplication >> request [
	^ requestAnswer
]

{ #category : 'accessing' }
PhLTestApplication >> requestAnswer: aString [
	requestAnswer := aString
]

{ #category : 'accessing' }
PhLTestApplication >> scriptsDirectory [

	^ scriptsDirectory ifNil: [ scriptsDirectory := (FileSystem identifiableMemory: #ScriptsStore) root ]
]

{ #category : 'asserting' }
PhLTestApplication >> shouldUpdateTemplateSources [
	^ false
]

{ #category : 'ui' }
PhLTestApplication >> showError: anError [

	requestAttributes at: #error put: anError
]

{ #category : 'accessing' }
PhLTestApplication >> templateRepository [
	^ 	templateRepository ifNil: [ templateRepository := PhLTemplateTestRepository new ] 
]

{ #category : 'request' }
PhLTestApplication >> title: aString [ 
	
	requestAttributes at: #title put: aString
]

{ #category : 'request' }
PhLTestApplication >> validateAnswer: aBlockClosure [ 
	"do nothing"
]
