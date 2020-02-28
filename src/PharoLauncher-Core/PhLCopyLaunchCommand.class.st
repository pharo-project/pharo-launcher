"
Copy the command used to launch the selected image to the system clipboard.
"
Class {
	#name : #PhLCopyLaunchCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLCopyLaunchCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallCopyIcon;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCopyLaunchCommand >> execute [
	Clipboard clipboardText: 
		self imagesPresenter selectedLaunchConfiguration commandString
]

{ #category : #initialization }
PhLCopyLaunchCommand >> initialize [
	super initialize.
	self name: 'Copy launch command'
]
