Class {
	#name : 'PhLRequestDialog',
	#superclass : 'SpRequestDialog',
	#category : 'PharoLauncher-Spec2-View-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Dialogs'
}

{ #category : 'layout' }
PhLRequestDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: (SpBoxLayout newVertical
				hAlignCenter;
				vAlignCenter;
				add: label;
				yourself) 
			expand: true;
		add: textInput expand: false;
		add: errorLabel;
		yourself
]

{ #category : 'initialization' }
PhLRequestDialog >> initializePresenters [

	super initializePresenters.
	label
		addStyle: 'message';
		beJustifyCenter;
		beWrap.
	textInput addStyle: 'request'.
	errorLabel 
		addStyle: 'message'; 
		addStyle: 'error'.	
	errorLabel hide
]

{ #category : 'initialization' }
PhLRequestDialog >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter 
		title: self title;
		initialExtent: self class defaultExtent;
		whenOpenedDo: [ textInput takeKeyboardFocus; selectAll ]
]

{ #category : 'initialization' }
PhLRequestDialog >> initializeWindowExtent: aDialogWindowPresenter [
]

{ #category : 'api' }
PhLRequestDialog >> label: aString [

	label label: aString.
	label ifNotNil: [  
		label show ]
]

{ #category : 'private' }
PhLRequestDialog >> newDialogLabel [

	^ self newLabel
]

{ #category : 'initialization' }
PhLRequestDialog >> setErrorText: aText [

	errorLabel label: aText asString.
	errorLabel visible: aText isEmptyOrNil not
	
]
