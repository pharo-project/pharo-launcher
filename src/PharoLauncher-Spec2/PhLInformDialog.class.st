Class {
	#name : 'PhLInformDialog',
	#superclass : 'SpInformDialog',
	#category : 'PharoLauncher-Spec2-View-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Dialogs'
}

{ #category : 'layout' }
PhLInformDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label expand: true;
		yourself
]

{ #category : 'initialization' }
PhLInformDialog >> initializePresenters [

	super initializePresenters.
	label
		addStyle: 'message';
		beJustifyCenter;
		beWrap
]

{ #category : 'initialization' }
PhLInformDialog >> initializeWindowExtent: aDialogWindowPresenter [
]

{ #category : 'api' }
PhLInformDialog >> label: aString [

	label label: aString trim.
	label ifNotNil: [  
		label show ]
]

{ #category : 'instance creation' }
PhLInformDialog >> newDialogLabel [

	^ self newLabel
]
