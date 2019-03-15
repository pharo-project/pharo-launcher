Class {
	#name : #PLCreateImageDialog,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameInputField',
		'nameInputLabel',
		'imageTypeList'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLCreateImageDialog class >> defaultSpec [
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
PLCreateImageDialog >> imageTypeList [
	
	^ imageTypeList
]

{ #category : #initialization }
PLCreateImageDialog >> initializeDialogWindow: aDialogWindowPresenter [
	"used to initialize the model in the case of the use into a dialog window.
	 Override this to set buttons other than the default (Ok, Cancel)."
	
	aDialogWindowPresenter
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		addButton: 'Create' do: [ :presenter | 
			presenter triggerOkAction.
			presenter close ]
]

{ #category : #initialization }
PLCreateImageDialog >> initializeWidgets [

	nameInputLabel := self newLabel.
	nameInputLabel label: 'Name:'.
	nameInputField := self newTextInput.
	
	imageTypeList := self instantiate: PLTemplateList on: self model.
]

{ #category : #initialization }
PLCreateImageDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Create new image';
		initialExtent: 600@500;
		centered
]

{ #category : #accessing }
PLCreateImageDialog >> nameInputField [
	
	^ nameInputField
]

{ #category : #accessing }
PLCreateImageDialog >> nameInputLabel [
	
	^ nameInputLabel
]
