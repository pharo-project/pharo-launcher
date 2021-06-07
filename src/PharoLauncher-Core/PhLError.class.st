"
I represent an error as can be signaled by any code of Pharo Launcher.
"
Class {
	#name : #PhLError,
	#superclass : #Error,
	#category : #'PharoLauncher-Core-Exceptions'
}

{ #category : #accessing }
PhLError >> longDescription [
	^ self subclassResponsibility
]

{ #category : #accessing }
PhLError >> name [
	^ self subclassResponsibility
]

{ #category : #ui }
PhLError >> uiAlert [

	PharoLauncherApplication default showError: self
]
