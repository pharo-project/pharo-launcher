"
A Morphic backend whose file dialogs are not opened: I answer the result given to me, as StFileDialogPresenter>>#openModal would.
"
Class {
	#name : 'PhLTestFileDialogMorphicBackend',
	#superclass : 'SpMorphicBackend',
	#instVars : [
		'dialogResult'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'accessing' }
PhLTestFileDialogMorphicBackend >> dialogResult: anObject [

	dialogResult := anObject
]

{ #category : 'private - dialogs' }
PhLTestFileDialogMorphicBackend >> newFileDialogFor: aFileDialog [

	^ self
]

{ #category : 'private - dialogs' }
PhLTestFileDialogMorphicBackend >> openModal [

	^ dialogResult
]
