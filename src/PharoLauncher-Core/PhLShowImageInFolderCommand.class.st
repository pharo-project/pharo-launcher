"
Open your OS's file browser on the selected image directory.
"
Class {
	#name : #PhLShowImageInFolderCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLShowImageInFolderCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLShowImageInFolderCommand class >> icon [
	^ self iconNamed: #openIcon
]

{ #category : #accessing }
PhLShowImageInFolderCommand class >> title [
	^ 'Show in folder'
]

{ #category : #action }
PhLShowImageInFolderCommand >> execute [
	self model singleImage showNativeFolder
]
