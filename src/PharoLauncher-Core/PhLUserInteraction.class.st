Class {
	#name : 'PhLUserInteraction',
	#superclass : 'Object',
	#instVars : [
		'parentWindow',
		'application'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'accessing' }
PhLUserInteraction >> application [

	^ application ifNil: [ PharoLauncherApplication default ]
]

{ #category : 'accessing' }
PhLUserInteraction >> application: anApplication [

	^ application := anApplication
]

{ #category : 'accessing' }
PhLUserInteraction >> parentWindow [
	
	^ parentWindow
]

{ #category : 'accessing' }
PhLUserInteraction >> parentWindow: aWindowPresenter [

	parentWindow := aWindowPresenter
]

{ #category : 'accessing' }
PhLUserInteraction >> relatedWindow [
	
	^ self parentWindow ifNil: [ self application topWindow ]
]
