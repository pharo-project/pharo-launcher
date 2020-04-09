"
Quit Pharo Launcher.
"
Class {
	#name : #PhLQuitCommand,
	#superclass : #PhLGeneralCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLQuitCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallQuitIcon;
		shortcutKey: $q meta;
		yourself
]

{ #category : #executing }
PhLQuitCommand >> execute [
	PhLDownloadManager reset. "reset error logging"
	Smalltalk snapshot: false andQuit: true
]

{ #category : #executing }
PhLQuitCommand >> initialize [
	super initialize.
	self
		name: 'Quit';
		description: 'Quit Pharo Launcher'
]
