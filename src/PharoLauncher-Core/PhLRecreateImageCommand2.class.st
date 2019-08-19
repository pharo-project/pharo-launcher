"
Refresh the currently selected image.
It will first drop the current local image and fetch a fresh version of the template. The name of the local image will not be updated.
"
Class {
	#name : #PhLRecreateImageCommand2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRecreateImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #refreshIcon;
		shortcutKey: $R meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #initialization }
PhLRecreateImageCommand2 >> initialize [
	super initialize.
	self
		basicName: 'Recreate';
		basicDescription: self class comment
]
