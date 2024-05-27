"
This error is thrown each time a command can not do its job.
"
Class {
	#name : 'PhLCommandError',
	#superclass : 'PhLError',
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
PhLCommandError >> longDescription [
	^ 'Pharo Launcher Command Error!'
]

{ #category : 'accessing' }
PhLCommandError >> name [
	^ 'command error'
]
