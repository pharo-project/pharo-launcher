"
Quit Pharo Launcher.
"
Class {
	#name : #PhLQuitCommand2,
	#superclass : #PhLGeneralCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLQuitCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallQuitIcon;
		shortcutKey: $q meta;
		yourself
]

{ #category : #executing }
PhLQuitCommand2 >> execute [
	PhLDownloadManager reset. "reset error logging"
	Smalltalk snapshot: true andQuit: true
]

{ #category : #executing }
PhLQuitCommand2 >> initialize [
	super initialize.
	self
		name: 'Quit';
		description: 'Quit Pharo Launcher'
]
