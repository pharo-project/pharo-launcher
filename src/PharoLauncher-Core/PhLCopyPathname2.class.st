"
Copy the selected image pathname to the system clipboard.

"
Class {
	#name : #PhLCopyPathname2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLCopyPathname2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallCopyIcon;
		shortcutKey: $c meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCopyPathname2 >> execute [
	Clipboard clipboardText: 
		self imagesPresenter singleImage file fullName surroundedByDoubleQuotes.
]

{ #category : #initialization }
PhLCopyPathname2 >> initialize [
	super initialize.
	self basicName: 'Copy'.
]
