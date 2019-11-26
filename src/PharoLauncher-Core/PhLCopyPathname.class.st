"
Copy the selected image pathname to the system clipboard.

"
Class {
	#name : #PhLCopyPathname,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLCopyPathname >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallCopyIcon;
		shortcutKey: $c meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCopyPathname >> execute [
	Clipboard clipboardText: 
		self imagesPresenter singleImage file fullName surroundedByDoubleQuotes.
]

{ #category : #initialization }
PhLCopyPathname >> initialize [
	super initialize.
	self name: 'Copy'
]
