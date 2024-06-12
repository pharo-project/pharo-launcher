Class {
	#name : 'PhLConfirmDialog',
	#superclass : 'SpConfirmDialog',
	#category : 'PharoLauncher-Spec2-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Dialogs'
}

{ #category : 'api' }
PhLConfirmDialog >> adjustExtentToLabelHeight: anExtent [

	^ anExtent
	"^ anExtent x @ (anExtent y - self singleLineDefaultHeight + (self calculateLabelHeightForTextWithoutMargin: label label forExtent: anExtent ))"
]

{ #category : 'layout' }
PhLConfirmDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		hAlignCenter;
		vAlignCenter;
		add: label expand: true;
		yourself
]

{ #category : 'initialization' }
PhLConfirmDialog >> initializePresenters [

	super initializePresenters.
	label
		addStyle: 'message';
		beJustifyCenter;
		beWrap
]

{ #category : 'initialization' }
PhLConfirmDialog >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	"aWindowPresenter withoutDecorations"
]

{ #category : 'api' }
PhLConfirmDialog >> label: aString [

	label label: aString trim.
	label ifNotNil: [  
		label show ]
]

{ #category : 'private' }
PhLConfirmDialog >> newDialogLabel [

	^ self newLabel
]

{ #category : 'initialization' }
PhLConfirmDialog >> updatePresenter [

	super updatePresenter
]
