"
Just quits the image.
"
Class {
	#name : #PhLQuitCommand,
	#superclass : #PhLGeneralCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLQuitCommand class >> icon [
	^ self iconNamed: #smallQuitIcon
]

{ #category : #accessing }
PhLQuitCommand class >> title [
	^ 'Quit'
]

{ #category : #action }
PhLQuitCommand >> execute [
	PhLDownloadManager reset. " reset error logging"
	Smalltalk snapshot: true andQuit: true
]
