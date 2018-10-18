"
Description
--------------------

I am an abstract class to manage the display of dates in the Pharo launcher UI. 

My subclasses should each implement a different format strategy.
"
Class {
	#name : #PhLAbstractDateDisplayStrategy,
	#superclass : #PhLObject,
	#category : 'PharoLauncher-Spec'
}

{ #category : #accessing }
PhLAbstractDateDisplayStrategy class >> allStrategies [
	^ self allSubclasses reject: #isAbstract
]

{ #category : #accessing }
PhLAbstractDateDisplayStrategy class >> allStrategiesWithNames [
	^ self allStrategies collect: [ :each | each label -> each ]
]

{ #category : #accessing }
PhLAbstractDateDisplayStrategy class >> displayStringOf: aDateAndTime [
	"Takes as parameter a DateAndTime and return a Text describing this date and time to the user."
	
	^ self subclassResponsibility
]

{ #category : #testing }
PhLAbstractDateDisplayStrategy class >> isAbstract [
	^ self = PhLAbstractDateDisplayStrategy
]

{ #category : #accessing }
PhLAbstractDateDisplayStrategy class >> label [
	^ self subclassResponsibility
]
