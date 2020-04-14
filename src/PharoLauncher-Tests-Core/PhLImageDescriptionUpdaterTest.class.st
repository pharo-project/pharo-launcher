"
A PhLImageDescriptionUpdaterTest is a test class for testing the behavior of PhLImageDescriptionUpdater
"
Class {
	#name : #PhLImageDescriptionUpdaterTest,
	#superclass : #TestCase,
	#instVars : [
		'updater',
		'image',
		'image2',
		'rootFs'
	],
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #running }
PhLImageDescriptionUpdaterTest >> setUp [
	updater := PhLImageDescriptionUpdaterMock
		reset;
		default.
	rootFs := FileSystem memory root.
	image := PhLImage location: rootFs / 'one'.
	image2 := PhLImage location: rootFs / 'two'.
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testDoNotSaveNullImage [
	updater image: PhLNullImage new description: 'desc'.
	
	self assert: updater nbSave equals: 0
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testDoNotSaveWhenImageIsNil [
	updater image: nil description: 'desc'.
	
	self assert: updater nbSave equals: 0
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testNoSaveWhenDescriptionIsTheSame [
	image description: 'desc'.
	updater image: image description: 'desc'.
	updater image: image description: 'desc'.
	self waitUpdate.
	
	self assert: updater nbSave equals: 0.
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testSaveBothImagesWhenUpdatingDescriptionOfTwoDifferentImages [
	updater image: image description: 'desc'.
	updater image: image2 description: 'desc imag2'.
	self waitUpdate.
	
	self assert: updater nbSave equals: 2
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testSaveOnceWhenDescriptionChangeOnce [
	updater image: image description: 'desc'.
	self waitUpdate.
	
	self assert: updater nbSave equals: 1
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testSaveOnceWhenDescriptionChangesManyTimesWithDelayShorterThanWaitDelay [
	3 timesRepeat: 
		[ updater image: image description: 'desc'.
		 (updater waitDelay / 5) wait ].
	self waitUpdate.
	
	self assert: updater nbSave equals: 1
]

{ #category : #tests }
PhLImageDescriptionUpdaterTest >> testSaveTwiceWhenDescriptionChangesManyTimesWithDelayLongerThanWaitDelay [
	3 timesRepeat: 
		[ updater image: image description: 'desc'.
		 self waitUpdate. ].
	
	self assert: updater nbSave equals: 3
]

{ #category : #utility }
PhLImageDescriptionUpdaterTest >> waitUpdate [
	(updater waitDelay + 100 milliSeconds) wait.
]
