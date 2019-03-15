Class {
	#name : #PLCreateImageDialog,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'nameInputField',
		'templateList'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLCreateImageDialog class >> defaultSpec [

	^ SpecBoxLayout newVertical
		borderWidth: 10;
		spacing: 10;
		add: 'Select image template' expand: false fill: false padding: 0;
		add: #templateList expand: true fill: true padding: 0;
		add: (SpecGridLayout new
				borderWidth: 0;
				rowSpacing: 0;
				add: 'Image name' at: 1 @ 1;
				add: #nameInputField at: 2 @ 1;
				yourself)
			expand: false 
			fill: false 
			padding: 0;
		yourself
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

	templateList := self instantiate: PLTemplateList on: self model.
	nameInputField := self newTextInput.
	
	self transmit 
		from: templateList;
		to: nameInputField;
		transform: [ :aTemplate | (aTemplate ifNil: [ '' ]) asString ]
]

{ #category : #initialization }
PLCreateImageDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Create new image';
		initialExtent: 800@500;
		centered
]
