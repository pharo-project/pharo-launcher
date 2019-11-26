"
Abstract superclass for all general-purpose commands. These commands concern the launcher in general, not a particular template or image.
"
Class {
	#name : #PhLGeneralCommand,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLGeneralCommand >> application [
	^ self context application
]
