Class {
	#name : #PLCreateImageDialogPresenter,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameInputField',
		'nameInputLabel',
		'imageTypeList'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLCreateImageDialogPresenter class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecGridLayout new
				add: #nameInputLabel at: 1 @ 1;
				add: #nameInputField at: 2 @ 1;
				yourself)
		expand: false fill: false padding: 0	;
		add: #imageTypeList expand: true fill: true padding: 5	;
		yourself
]

{ #category : #accessing }
PLCreateImageDialogPresenter >> imageTypeList [
	
	^ imageTypeList
]

{ #category : #initialization }
PLCreateImageDialogPresenter >> initializeWidgets [

	nameInputLabel := self newLabel.
	nameInputLabel label: 'Name:'.
	nameInputField := self newTextInput.
	
	imageTypeList := self instantiate: PLTemplateList on: self model.
]

{ #category : #accessing }
PLCreateImageDialogPresenter >> nameInputField [
	
	^ nameInputField
]

{ #category : #accessing }
PLCreateImageDialogPresenter >> nameInputLabel [
	
	^ nameInputLabel
]
