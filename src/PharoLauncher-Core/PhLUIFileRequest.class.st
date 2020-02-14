Class {
	#name : #PhLUIFileRequest,
	#superclass : #PhLUserInteraction,
	#instVars : [
		'title',
		'extensionsToShow',
		'path'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLUIFileRequest >> chooseFullFileName [
	^ UIManager default
		chooseExistingFileReference: title
		extensions: extensionsToShow
		path: path
		preview: false.
]

{ #category : #accessing }
PhLUIFileRequest >> extensionsToShow: anObject [
	extensionsToShow := anObject
]

{ #category : #accessing }
PhLUIFileRequest >> path: anObject [
	path := anObject
]

{ #category : #accessing }
PhLUIFileRequest >> title: anObject [
	title := anObject
]
