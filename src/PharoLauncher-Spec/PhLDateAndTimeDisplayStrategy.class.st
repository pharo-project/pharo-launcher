"
Description
--------------------

Display date with the date and time. 

Example:

2018-07-03 10:37:53
"
Class {
	#name : #PhLDateAndTimeDisplayStrategy,
	#superclass : #PhLAbstractDateDisplayStrategy,
	#category : 'PharoLauncher-Spec'
}

{ #category : #accessing }
PhLDateAndTimeDisplayStrategy class >> displayStringOf: aDateAndTime [
	^ (String
		streamContents: [ :s | 
			s
				nextPutAll: aDateAndTime asDate yyyymmdd;
				space.
			aDateAndTime asTime print24: true on: s ]) asText
]

{ #category : #accessing }
PhLDateAndTimeDisplayStrategy class >> label [
	^ 'Date and time'
]
