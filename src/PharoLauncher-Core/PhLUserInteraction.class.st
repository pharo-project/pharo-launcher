Class {
	#name : 'PhLUserInteraction',
	#superclass : 'Object',
	#instVars : [
		'parentWindow'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'accessing' }
PhLUserInteraction >> application [

	^ PharoLauncherApplication default
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
