"
Open your OS's file browser on the selected image directory.
"
Class {
	#name : #PhLShowImageInFolderCommand2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLShowImageInFolderCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #openIcon;
		shortcutKey: $o meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLShowImageInFolderCommand2 >> execute [
	self imagesPresenter singleImage showNativeFolder
]

{ #category : #initialization }
PhLShowImageInFolderCommand2 >> initialize [
	super initialize.
	self name: 'Show in folder'
]
