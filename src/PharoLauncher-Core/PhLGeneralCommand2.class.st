"
Abstract superclass for all general-purpose commands. These commands concern the launcher in general, not a particular template or image.
"
Class {
	#name : #PhLGeneralCommand2,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #accessing }
PhLGeneralCommand2 >> application [
	^ self context application
]
