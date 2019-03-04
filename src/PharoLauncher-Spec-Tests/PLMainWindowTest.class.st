Class {
	#name : #PLMainWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'window'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #tests }
PLMainWindowTest >> setUp [ 

	super setUp.
	instance := PLMainWindow on: PhLDirectoryBasedImageRepository default.
	window := instance openWithSpec

]

{ #category : #tests }
PLMainWindowTest >> tearDown [

	instance ifNotNil: [ :x | x window close ].
	super tearDown

]

{ #category : #tests }
PLMainWindowTest >> testLauncherHasButton [

	self assert: (window hasPresenter: instance runButton)
]

{ #category : #tests }
PLMainWindowTest >> testLauncherHasImageList [

	self assert: (window hasPresenter: instance imageList)
]

{ #category : #tests }
PLMainWindowTest >> testNewLauncherHasDisabledRunButton [

	self deny: instance runButton isEnabled 
]

{ #category : #tests }
PLMainWindowTest >> testNewLauncherHasEmptySelection [

	self assert: instance imageList selection isEmpty
]

{ #category : #tests }
PLMainWindowTest >> testNoSelectionDisablesRunButton [

	instance imageList unselectAll. 
	self deny: instance runButton isEnabled
]

{ #category : #tests }
PLMainWindowTest >> testSelectionEnablesRunButton [

	instance imageList selectIndex: 1. 
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
