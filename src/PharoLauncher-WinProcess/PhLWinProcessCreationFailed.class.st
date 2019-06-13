"
Error thrown when the creation of a sub process fails.
"
Class {
	#name : #PhLWinProcessCreationFailed,
	#superclass : #Error,
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #accessing }
PhLWinProcessCreationFailed >> description [
	^ 'Failed to create a new process'
]
