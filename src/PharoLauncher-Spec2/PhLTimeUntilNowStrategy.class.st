"
Description
--------------------

Display date by its delta with the current date.

Example:

1 year ago
2 weeks ago
3 days ago
"
Class {
	#name : #PhLTimeUntilNowStrategy,
	#superclass : #PhLAbstractDateDisplayStrategy,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #accessing }
PhLTimeUntilNowStrategy class >> displayStringOf: aDateAndTime [
	^ (DateAndTime now - aDateAndTime) simpleTimeAgo asText
]

{ #category : #accessing }
PhLTimeUntilNowStrategy class >> label [
	^ 'Time since now'
]
