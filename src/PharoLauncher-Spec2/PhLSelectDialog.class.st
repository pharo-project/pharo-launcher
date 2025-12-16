Class {
	#name : 'PhLSelectDialog',
	#superclass : 'SpSelectDialog',
	#category : 'PharoLauncher-Spec2-View-Dialogs',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Dialogs'
}

{ #category : 'accessing' }
PhLSelectDialog class >> defaultExtent [

	^ 650@300
]

{ #category : 'layout' }
PhLSelectDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
				hAlignCenter;
				add: label;
				yourself) 
			expand: false;
		add: list;
		yourself
]

{ #category : 'initialization' }
PhLSelectDialog >> initializePresenters [

	super initializePresenters.
	list := self instantiate: PhLRadioButtonListPresenter.
	label
		addStyle: 'message';
		beJustifyCenter;
		beWrap
]

{ #category : 'initialization' }
PhLSelectDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: self class defaultExtent;
		whenOpenedDo: [ list takeKeyboardFocus ]
]

{ #category : 'initialization' }
PhLSelectDialog >> initializeWindowExtent: aDialogWindowPresenter [
]

{ #category : 'api' }
PhLSelectDialog >> label: aString [

	label label: aString.
	label ifNotNil: [  
		label show ]
]

{ #category : 'private' }
PhLSelectDialog >> newDialogLabel [

	^ self newLabel
]
