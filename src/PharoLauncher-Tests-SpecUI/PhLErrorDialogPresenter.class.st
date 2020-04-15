"
A small presenter to catch errors and present them nicely to the user.
I provide an acknowledge button ('ok') and a debug button that will open the Pharo debugger.

	self example
"
Class {
	#name : #PhLErrorDialogPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'description',
		'acceptButton',
		'cancelButton',
		'exception'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #specs }
PhLErrorDialogPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #description;
		yourself
]

{ #category : #example }
PhLErrorDialogPresenter class >> example [ 
	[ NotFound signal: 'foo'. ]
		on: NotFound 
		do: [ :exception |
				^ (self on: exception)
					openDialogWithSpec;
					yourself. ]
]

{ #category : #accessing }
PhLErrorDialogPresenter >> exception [ 
	^ exception
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter buttons
		detect: [ :button | button label = 'Ok' ]
		ifFound: [ :button | button label: 'Debug' ].
	aDialogWindowPresenter buttons
		detect: [ :button | button label = 'Cancel' ]
		ifFound: [ :button | button label: 'Ignore' ].
	aDialogWindowPresenter 
		okAction: [ 	self delete.
						self exception freeze; debug. ]
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializePresenters [ 
	description := self newText
		beNotEditable;
		text: self exception description, String cr, self exception messageText;
		yourself.
]

{ #category : #initialization }
PhLErrorDialogPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		title: 'An error occured!';
		initialExtent: 390 @ 167.
]

{ #category : #initialization }
PhLErrorDialogPresenter >> setModelBeforeInitialization: anException [
	exception := anException
]
