"
Open your OS's file browser on the selected image directory.
"
Class {
	#name : #PhLShowImageInFolderCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLShowImageInFolderCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #openIcon;
		shortcutKey: $o meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLShowImageInFolderCommand >> execute [
	self imagesPresenter singleImage showNativeFolder
]

{ #category : #initialization }
PhLShowImageInFolderCommand >> initialize [
	super initialize.
	self name: 'Show in folder'
]
