"
This error is thrown each time a command can not do its job.
"
Class {
	#name : #PhLCommandError,
	#superclass : #PhLError,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLCommandError >> longDescription [
	^ 'Pharo Launcher Command Error!'
]

{ #category : #accessing }
PhLCommandError >> name [
	^ 'command error'
]
