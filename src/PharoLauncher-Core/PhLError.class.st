"
I represent an error as can be signaled by any code of Pharo Launcher.
"
Class {
	#name : 'PhLError',
	#superclass : 'Error',
	#category : 'PharoLauncher-Core-Exceptions',
	#package : 'PharoLauncher-Core',
	#tag : 'Exceptions'
}

{ #category : 'testing' }
PhLError >> isResumable [ 
	^ true
]

{ #category : 'accessing' }
PhLError >> longDescription [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
PhLError >> name [
	^ self subclassResponsibility
]

{ #category : 'ui' }
PhLError >> uiAlert [

	PharoLauncherApplication default showError: self
]
