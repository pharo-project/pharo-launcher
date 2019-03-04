Class {
	#name : #PLMainWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'window',
		'imageRepository',
		'modifiedTime',
		'testImage'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #asserting }
PLMainWindowTest >> assertImageColumn: aColumnName equals: aValue [ 

	| column |
	column := instance imageTable columns detect: [ :e | e title = aColumnName ].
	self assert: (column readObject: imageRepository images first) equals: aValue
]

{ #category : #tests }
PLMainWindowTest >> setUp [ 

	super setUp.
	imageRepository := PLMemoryImageRepository new.
	modifiedTime := DateAndTime now.
	testImage := PhLMockImage named: 'TestImage' arch: '32' modified: modifiedTime.
	imageRepository addImage: testImage.
	
	instance := PLMainWindow on: imageRepository.
	window := instance openWithSpec

]

{ #category : #tests }
PLMainWindowTest >> tearDown [

	instance ifNotNil: [ :x | x window close ].
	super tearDown

]

{ #category : #tests }
PLMainWindowTest >> testImageArchColumnDisplaysCorrectValue [

	self assertImageColumn: 'Architecture' equals: '32'
]

{ #category : #tests }
PLMainWindowTest >> testImageModifiedColumnDisplaysCorrectValue [

	self assertImageColumn: 'Modified' equals: 'just now' asText
]

{ #category : #tests }
PLMainWindowTest >> testImageNameColumnDisplaysCorrectValue [

	self assertImageColumn: 'Name' equals: 'TestImage'
]

{ #category : #tests }
PLMainWindowTest >> testImagesHasArchColumn [

	self assert: (instance imageTable columns anySatisfy: [ :e | e title = 'Architecture' ])
]

{ #category : #tests }
PLMainWindowTest >> testImagesHasModifiedColumn [

	self assert: (instance imageTable columns anySatisfy: [ :e | e title = 'Modified' ])
]

{ #category : #tests }
PLMainWindowTest >> testImagesHasNameColumn [

	self assert: (instance imageTable columns anySatisfy: [ :e | e title = 'Name' ])
]

{ #category : #tests }
PLMainWindowTest >> testLauncherHasButton [

	self assert: (window hasPresenter: instance runButton)
]

{ #category : #tests }
PLMainWindowTest >> testLauncherHasImages [

	self assert: (window hasPresenter: instance imageTable)
]

{ #category : #tests }
PLMainWindowTest >> testNewLauncherHasDisabledRunButton [

	self deny: instance runButton isEnabled 
]

{ #category : #tests }
PLMainWindowTest >> testNewLauncherHasEmptySelection [

	self assert: instance imageTable selection isEmpty
]

{ #category : #tests }
PLMainWindowTest >> testNoSelectionDisablesRunButton [

	instance imageTable unselectAll. 
	self deny: instance runButton isEnabled
]

{ #category : #tests }
PLMainWindowTest >> testNonSelectionAndClickRunButtonLaunchesImage [

	instance runButton click.
	
	self deny: testImage isLaunched
]

{ #category : #tests }
PLMainWindowTest >> testSelectingImageAndClickRunButtonLaunchesImage [

	instance imageTable selectIndex: 1.
	instance runButton click.
	
	self assert: testImage isLaunched
]

{ #category : #tests }
PLMainWindowTest >> testSelectionEnablesRunButton [

	instance imageTable selectIndex: 1. 
	self assert: instance runButton isEnabled
]

{ #category : #tests }
PLMainWindowTest >> testSmoke [

	"I am a fucking smoke seller"
]

{ #category : #tests }
PLMainWindowTest >> testWindowTitle [

	self assert: window title equals: 'Pharo Launcher'.
]
