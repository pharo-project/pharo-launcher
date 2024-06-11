"
Open your OS's file browser on the selected image directory.
"
Class {
	#name : 'PhLShowImageInFolderCommand',
	#superclass : 'PhLImageCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLShowImageInFolderCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #open;
		shortcutKey: $a actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'executing' }
PhLShowImageInFolderCommand >> execute [
 
	self imagesPresenter hasSingleImageSelected ifFalse: [ ^self ].
	self imagesPresenter singleImage showNativeFolder
]

{ #category : 'initialization' }
PhLShowImageInFolderCommand >> initialize [
	super initialize.
	self name: 'Show in folder'
]
