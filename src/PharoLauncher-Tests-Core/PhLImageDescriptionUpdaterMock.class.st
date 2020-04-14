"
I override the save method to remember the number of time the real ImageDescriptionUpdater would have saved the image metadata.
"
Class {
	#name : #PhLImageDescriptionUpdaterMock,
	#superclass : #PhLImageDescriptionUpdater,
	#instVars : [
		'nbProcessKilled',
		'saves'
	],
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #saving }
PhLImageDescriptionUpdaterMock >> doSave [
	saves add: { image name -> description }
]

{ #category : #initialization }
PhLImageDescriptionUpdaterMock >> initialize [
	super initialize.
	saves := OrderedCollection new.
	nbProcessKilled := 0.
]

{ #category : #accessing }
PhLImageDescriptionUpdaterMock >> nbProcessKilled [
	^ nbProcessKilled
]

{ #category : #accessing }
PhLImageDescriptionUpdaterMock >> nbSave [
	^ saves size
]

{ #category : #private }
PhLImageDescriptionUpdaterMock >> terminateProcess [ 
	super terminateProcess.
	process ifNotNil: [ nbProcessKilled := nbProcessKilled + 1 ].
]

{ #category : #accessing }
PhLImageDescriptionUpdaterMock >> waitDelay [
	^ 100 milliSeconds
]
